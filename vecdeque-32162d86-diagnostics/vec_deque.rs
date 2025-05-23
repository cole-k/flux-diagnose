// SPDX-License-Identifier: Apache-2.0 OR MIT
//
// Modifications Copyright Kani Contributors
// See GitHub history for details.

//! This is a modified version of rust std collections/vec_deque/mod.rs

//! A double-ended queue (deque) implemented with a growable ring buffer.
//!
//! This queue has *O*(1) amortized inserts and removals from both ends of the
//! container. It also has *O*(1) indexing like a vector. The contained elements
//! are not required to be copyable, and the queue will be sendable if the
//! contained type is sendable.
use flux_rs::*;

#[allow(unsafe_op_in_unsafe_fn)]
// use core::slice;
use crate::raw_vec::RawVec;
use std::alloc::{Allocator, Global};
pub use std::collections::vec_deque::*;
use std::{cmp, mem, ptr};

// #[flux::constant]
const INITIAL_CAPACITY: usize = 7; // 2^3 - 1
const MINIMUM_CAPACITY: usize = 1; // 2 - 1

// #[flux::constant]
const MAXIMUM_ZST_CAPACITY: usize = 1 << (usize::BITS - 1); // Largest possible power of two

#[flux::alias(type Size = usize{v: pow2(v) && 1<=v })]
type Size = usize;

/// A double-ended queue implemented with a growable ring buffer.
///
/// The "default" usage of this type as a queue is to use [`push_back`] to add to
/// the queue, and [`pop_front`] to remove from the queue. [`extend`] and [`append`]
/// push onto the back in this manner, and iterating over `VecDeque` goes front
/// to back.
///
/// A `VecDeque` with a known list of items can be initialized from an array:
///
/// ```
/// use std::collections::VecDeque;
///
/// let deq = VecDeque::from([-1, 0, 1]);
/// ```
///
/// Since `VecDeque` is a ring buffer, its elements are not necessarily contiguous
/// in memory. If you want to access the elements as a single slice, such as for
/// efficient sorting, you can use [`make_contiguous`]. It rotates the `VecDeque`
/// so that its elements do not wrap, and returns a mutable slice to the
/// now-contiguous element sequence.
///
/// [`push_back`]: VecDeque::push_back
/// [`pop_front`]: VecDeque::pop_front
/// [`extend`]: VecDeque::extend
/// [`append`]: VecDeque::append
/// [`make_contiguous`]: VecDeque::make_contiguous
//#[cfg_attr(not(test), rustc_diagnostic_item = "VecDeque")]
//#[stable(feature = "rust1", since = "1.0.0")]
#[rustc_insignificant_dtor]
#[flux::refined_by(head:int, tail:int, cap:int)]
pub struct VecDeque<
    T,
    //#[unstable(feature = "allocator_api", issue = "32838")]
    A: Allocator = Global,
> {
    // tail and head are pointers into the buffer. Tail always points
    // to the first element that could be read, Head always points
    // to where data should be written.
    // If tail == head the buffer is empty. The length of the ringbuffer
    // is defined as the distance between the two.
    #[flux::field({ usize[tail] | tail < cap })]
    tail: usize,
    #[flux::field({ usize[head] | head < cap })]
    head: usize,
    #[flux::field({ RawVec<T, A>[cap] | pow2(cap) && 1 <= cap } )]
    buf: RawVec<T, A>,
}

//#[stable(feature = "rust1", since = "1.0.0")]
impl<T> Default for VecDeque<T> {
    /// Creates an empty deque.
    #[inline]
    fn default() -> VecDeque<T> {
        VecDeque::new()
    }
}

impl<T, A: Allocator> VecDeque<T, A> {
    /// Marginally more convenient
    #[inline]
    fn ptr(&self) -> *mut T {
        self.buf.ptr()
    }

    /// Marginally more convenient
    #[inline]
    // TODO: remove trusted. Right now this signature is not strictly
    // accurate due to ZST nonsense, although it would be without it.
    #[flux::trusted]
    #[flux::sig(fn (&VecDeque<T,A>[@self]) -> Size{v: v == self.cap})]
    fn cap(&self) -> Size {
        if mem::size_of::<T>() == 0 {
            // For zero sized types, we are always at maximum capacity
            MAXIMUM_ZST_CAPACITY
        } else {
            self.buf.capacity()
        }
    }

    /// Writes an element into the buffer, moving it.
    #[inline]
    unsafe fn buffer_write(&mut self, off: usize, value: T) {
        unsafe {
            ptr::write(self.ptr().add(off), value);
        }
    }

    /// Returns `true` if the buffer is at full capacity.
    #[inline]
    fn is_full(&self) -> bool {
        self.cap() - self.len() == 1
    }

    /// Returns the index in the underlying buffer for a given logical element
    /// index + addend.
    #[inline]
    fn wrap_add(&self, idx: usize, addend: usize) -> usize {
        wrap_index(idx.wrapping_add(addend), self.cap())
    }

    /// Returns the index in the underlying buffer for a given logical element
    /// index - subtrahend.
    #[inline]
    fn wrap_sub(&self, idx: usize, subtrahend: usize) -> usize {
        wrap_index(idx.wrapping_sub(subtrahend), self.cap())
    }

    /// Copies a contiguous block of memory len long from src to dst
    #[inline]
    unsafe fn copy_nonoverlapping(&self, dst: usize, src: usize, len: usize) {
        // TODO: Uncomment
        // assert(dst + len <= self.cap());
        // assert(src + len <= self.cap());

        // debug_assert!(
        //     dst + len <= self.cap(),
        //     "cno dst={} src={} len={} cap={}",
        //     dst,
        //     src,
        //     len,
        //     self.cap()
        // );
        // debug_assert!(
        //     src + len <= self.cap(),
        //     "cno dst={} src={} len={} cap={}",
        //     dst,
        //     src,
        //     len,
        //     self.cap()
        // );
        unsafe {
            ptr::copy_nonoverlapping(self.ptr().add(src), self.ptr().add(dst), len);
        }
    }

    /// Frobs the head and tail sections around to handle the fact that we
    /// just reallocated. Unsafe because it trusts old_capacity.
    #[inline]
    #[flux::sig(fn (self: &strg VecDeque<T,A>[@s], old_capacity: usize{v: v * 2 <= s.cap && s.tail < v}) ensures self: VecDeque<T, A>)]
    unsafe fn handle_capacity_increase(&mut self, old_capacity: usize) {
        let new_capacity = self.cap();

        // Move the shortest contiguous section of the ring buffer
        //    T             H
        //   [o o o o o o o . ]
        //    T             H
        // A [o o o o o o o . . . . . . . . . ]
        //        H T
        //   [o o . o o o o o ]
        //          T             H
        // B [. . . o o o o o o o . . . . . . ]
        //              H T
        //   [o o o o o . o o ]
        //              H                 T
        // C [o o o o o . . . . . . . . . o o ]

        if self.tail <= self.head {
            // A
            // Nop
        } else if self.head < old_capacity - self.tail {
            // B
            unsafe {
                let head = self.head;
                self.copy_nonoverlapping(old_capacity, 0, head); // FLUX-PANIC: self.head -> head
            }
            self.head += old_capacity;
            debug_assert!(self.head > self.tail);
        } else {
            // C
            let new_tail = new_capacity - (old_capacity - self.tail);
            {
                let tail = self.tail;
                self.copy_nonoverlapping(new_tail, tail, old_capacity - tail); // FLUX-PANIC: self.tail -> tail
            }
            self.tail = new_tail;
            debug_assert!(self.head < self.tail);
        }
        // TODO: Uncomment
        // // FLUX debug_assert!(self.head < self.cap());
        // assert(self.head < self.cap());
        // // FLUX debug_assert!(self.tail < self.cap());
        // assert(self.tail < self.cap());
        // // FLUX debug_assert!(self.cap().count_ones() == 1);
        // assert(is_power_of_two(self.cap()));
    }
}

impl<T> VecDeque<T> {
    /// Creates an empty deque.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let deque: VecDeque<u32> = VecDeque::new();
    /// ```
    #[inline]
    //#[stable(feature = "rust1", since = "1.0.0")]
    #[must_use]
    pub fn new() -> VecDeque<T> {
        VecDeque::new_in(Global)
    }
    /// Creates an empty deque with space for at least `capacity` elements.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let deque: VecDeque<u32> = VecDeque::with_capacity(10);
    /// ```
    #[inline]
    //#[stable(feature = "rust1", since = "1.0.0")]
    #[must_use]
    pub fn with_capacity(capacity: usize) -> VecDeque<T> {
        Self::with_capacity_in(capacity, Global)
    }
}

impl<T, A: Allocator> VecDeque<T, A> {
    /// Creates an empty deque.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let deque: VecDeque<u32> = VecDeque::new();
    /// ```
    #[inline]
    //#[unstable(feature = "allocator_api", issue = "32838")]
    fn new_in(alloc: A) -> VecDeque<T, A> {
        VecDeque::with_capacity_in(INITIAL_CAPACITY, alloc)
    }

    /// Creates an empty deque with space for at least `capacity` elements.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let deque: VecDeque<u32> = VecDeque::with_capacity(10);
    /// ```
    //#[unstable(feature = "allocator_api", issue = "32838")]
    #[flux::sig(fn (capacity: usize{capacity < MAXIMUM_ZST_CAPACITY && capacity > 1}, alloc: A) -> VecDeque<T, A>{v: v.head == 0 && v.tail == 0 && capacity <= v.cap})]
    fn with_capacity_in(capacity: usize, alloc: A) -> VecDeque<T, A> {
        // FLUX-TODO: same as MAXIMUM_ZST_CAPACITY?: assert!(capacity < 1_usize << usize::BITS - 1, "capacity overflow");
        // TODO: Uncomment
        // assert(capacity < MAXIMUM_ZST_CAPACITY);
        // +1 since the ringbuffer always leaves one space empty
        let cap = real_capacity(capacity);

        VecDeque {
            tail: 0,
            head: 0,
            buf: RawVec::with_capacity_in(cap, alloc),
        }
    }

    /// Provides a reference to the element at the given index.
    ///
    /// Element at index 0 is the front of the queue.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let mut buf = VecDeque::new();
    /// buf.push_back(3);
    /// buf.push_back(4);
    /// buf.push_back(5);
    /// assert_eq!(buf.get(1), Some(&4));
    /// ```
    //#[stable(feature = "rust1", since = "1.0.0")]
    #[flux::trusted] // ptr
    pub fn get(&self, index: usize) -> Option<&T> {
        if index < self.len() {
            let idx = self.wrap_add(self.tail, index);
            unsafe { Some(&*self.ptr().add(idx)) }
        } else {
            None
        }
    }

    /// Provides a mutable reference to the element at the given index.
    ///
    /// Element at index 0 is the front of the queue.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let mut buf = VecDeque::new();
    /// buf.push_back(3);
    /// buf.push_back(4);
    /// buf.push_back(5);
    /// if let Some(elem) = buf.get_mut(1) {
    ///     *elem = 7;
    /// }
    ///
    /// assert_eq!(buf[1], 7);
    /// ```
    //#[stable(feature = "rust1", since = "1.0.0")]
    #[flux::trusted]
    pub fn get_mut(&mut self, index: usize) -> Option<&mut T> {
        if index < self.len() {
            let idx = self.wrap_add(self.tail, index);
            unsafe { Some(&mut *self.ptr().add(idx)) }
        } else {
            None
        }
    }

    /// Returns the number of elements the deque can hold without
    /// reallocating.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let buf: VecDeque<i32> = VecDeque::with_capacity(10);
    /// assert!(buf.capacity() >= 10);
    /// ```
    #[inline]
    //#[stable(feature = "rust1", since = "1.0.0")]
    pub fn capacity(&self) -> usize {
        self.cap() - 1
    }

    /// Reserves capacity for at least `additional` more elements to be inserted in the given
    /// deque. The collection may reserve more space to avoid frequent reallocations.
    ///
    /// # Panics
    ///
    /// Panics if the new capacity overflows `usize`.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let mut buf: VecDeque<i32> = [1].into();
    /// buf.reserve(10);
    /// assert!(buf.capacity() >= 11);
    /// ```
    //#[stable(feature = "rust1", since = "1.0.0")]
    #[flux::sig(fn (self: &strg VecDeque<T, A>[@s], additional: usize) ensures self: VecDeque<T,A>)]
    pub fn reserve(&mut self, additional: usize) {
        let old_cap = self.cap();
        let used_cap = self.len() + 1;
        let new_cap = new_capacity(old_cap, used_cap, additional);

        // *** This is the issue! new_cap is related to underlying buffer, capacity() is not.
        if new_cap > old_cap
        /* BUG self.capacity() */
        {
            self.buf.reserve_exact(used_cap, new_cap - used_cap);
            // new_cap <= self.cap, old_cap < new_cap => 2 * old_cap <= new_cap
            unsafe {
                self.handle_capacity_increase(old_cap);
            }
        }
    }

    /// Returns the number of elements in the deque.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let mut deque = VecDeque::new();
    /// assert_eq!(deque.len(), 0);
    /// deque.push_back(1);
    /// assert_eq!(deque.len(), 1);
    /// ```
    //#[stable(feature = "rust1", since = "1.0.0")]
    #[flux::sig(fn (&VecDeque<T,A>[@self]) -> usize{v: v < self.cap})]
    pub fn len(&self) -> usize {
        count(self.tail, self.head, self.cap())
    }

    /// Returns `true` if the deque is empty.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let mut deque = VecDeque::new();
    /// assert!(deque.is_empty());
    /// deque.push_front(1);
    /// assert!(!deque.is_empty());
    /// ```
    //#[stable(feature = "rust1", since = "1.0.0")]
    pub fn is_empty(&self) -> bool {
        self.tail == self.head
    }

    /// Provides a reference to the front element, or `None` if the deque is
    /// empty.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let mut d = VecDeque::new();
    /// assert_eq!(d.front(), None);
    ///
    /// d.push_back(1);
    /// d.push_back(2);
    /// assert_eq!(d.front(), Some(&1));
    /// ```
    //#[stable(feature = "rust1", since = "1.0.0")]
    pub fn front(&self) -> Option<&T> {
        self.get(0)
    }

    /// Provides a mutable reference to the front element, or `None` if the
    /// deque is empty.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let mut d = VecDeque::new();
    /// assert_eq!(d.front_mut(), None);
    ///
    /// d.push_back(1);
    /// d.push_back(2);
    /// match d.front_mut() {
    ///     Some(x) => *x = 9,
    ///     None => (),
    /// }
    /// assert_eq!(d.front(), Some(&9));
    /// ```
    //#[stable(feature = "rust1", since = "1.0.0")]
    pub fn front_mut(&mut self) -> Option<&mut T> {
        self.get_mut(0)
    }

    /// Provides a reference to the back element, or `None` if the deque is
    /// empty.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let mut d = VecDeque::new();
    /// assert_eq!(d.back(), None);
    ///
    /// d.push_back(1);
    /// d.push_back(2);
    /// assert_eq!(d.back(), Some(&2));
    /// ```
    //#[stable(feature = "rust1", since = "1.0.0")]
    pub fn back(&self) -> Option<&T> {
        self.get(self.len().wrapping_sub(1))
    }

    /// Prepends an element to the deque.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let mut d = VecDeque::new();
    /// d.push_front(1);
    /// d.push_front(2);
    /// assert_eq!(d.front(), Some(&2));
    /// ```
    //#[stable(feature = "rust1", since = "1.0.0")]
    pub fn push_front(&mut self, value: T) {
        if self.is_full() {
            self.grow();
        }

        let tail = self.tail;
        self.tail = self.wrap_sub(tail, 1);
        let tail = self.tail;
        unsafe {
            self.buffer_write(tail, value);
        }
    }

    /// Appends an element to the back of the deque.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::collections::VecDeque;
    ///
    /// let mut buf = VecDeque::new();
    /// buf.push_back(1);
    /// buf.push_back(3);
    /// assert_eq!(3, *buf.back().unwrap());
    /// ```
    //#[stable(feature = "rust1", since = "1.0.0")]
    pub fn push_back(&mut self, value: T) {
        if self.is_full() {
            self.grow();
        }

        let head = self.head;
        self.head = self.wrap_add(self.head, 1);
        unsafe { self.buffer_write(head, value) }
    }

    // Double the buffer size. This method is inline(never), so we expect it to only
    // be called in cold paths.
    // This may panic or abort
    #[inline(never)]
    fn grow(&mut self) {
        // Extend or possibly remove this assertion when valid use-cases for growing the
        // buffer without it being full emerge
        debug_assert!(self.is_full());
        let old_cap = self.cap();
        self.buf.reserve_exact(old_cap, old_cap);
        // let _ = lem_power_two(old_cap);
        let new_cap = self.cap();
        // TODO: Uncomment
        assert(new_cap == old_cap * 2);
        unsafe {
            self.handle_capacity_increase(old_cap);
        }
        debug_assert!(!self.is_full());
    }
}

/// Returns the index in the underlying buffer for a given logical element index.
#[inline]
#[flux::sig(fn(index: usize, size: Size) -> usize)]
fn wrap_index(index: usize, size: Size) -> usize {
    // size is always a power of 2
    // TODO: Uncomment
    // assert(is_power_of_two(size));
    index & (size - 1)
}

/// Calculate the number of elements left to be read in the buffer
#[inline]
fn count(tail: usize, head: usize, size: Size) -> usize {
    // size is always a power of 2
    // (head.wrapping_sub(tail)) & (size - 1)
    wrap_index(head.wrapping_sub(tail), size)
}

fn lem_power_two(_: usize) -> bool {
    true
}

fn is_power_of_two(n: usize) -> bool {
    // n.count_ones() == 1
    n.is_power_of_two()
}

#[flux::sig(fn(bool[true]))]
fn assert(_: bool) {}

#[flux::trusted]
#[flux::sig(fn(capacity: usize) -> usize{v: v >= 1 && pow2(v)})]
fn real_capacity(capacity: usize) -> usize {
    cmp::max(capacity + 1, MINIMUM_CAPACITY + 1).next_power_of_two()
}

#[flux::trusted]
// Why should you trust this? Because this is saying that the output is a power of 2 such that
//   1. It has enough capacity for used_cap + additional
//   2. If old_cap is not already big enough, it is at least 2x old_cap.
// The rationale for the latter is somewhat complicated and its proof comes from the
// fact that the capacity is always a power of 2. So if old_cap is not big enough,
// we will move up (at least) to the next power of 2 greater than it.
//
// In an ideal world, flux would know about .checked_next_power_of_two() as well
// as support the machinery necessary to mechanize this proof. Well, it may
// already (we could certainly add a trusted sig to that function), but for
// now I won't do the proof.
#[flux::sig(fn(old_cap: usize, used_cap: usize, additional: usize) -> usize{v: used_cap + additional <= v && pow2(v) && (old_cap < v => 2 * old_cap <= v) })]
fn new_capacity(_old_cap: usize, used_cap: usize, additional: usize) -> usize {
    used_cap
        .checked_add(additional)
        .and_then(|needed_cap| needed_cap.checked_next_power_of_two())
        .expect("capacity overflow")
}

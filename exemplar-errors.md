# Example errors of each type

# Types

## 1a

Postcondition error
Fix is strengthening another function used in the body


### Ex2: len

```
=================
ERROR: len-L417-0
=================
Error Message: error[E0999]: refinement type error
   --> src/vec_deque.rs:417:9
    |
417 |         count(self.tail, self.head, self.cap())
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ a postcondition cannot be proved
    |
note: this is the condition that cannot be proved
   --> src/vec_deque.rs:415:56
    |
415 |     #[flux::sig(fn (&VecDeque<T,A>[@self]) -> usize{v: v < self.cap})]
    |                                                        ^^^^^^^^^^^^


src/vec_deque.rs
415:                 #[flux::sig(fn (&VecDeque<T,A>[@self]) -> usize{v: v < self.cap})]
416:                 pub fn len(&self) -> usize {
417: error> fix>         count(self.tail, self.head, self.cap())
418:                 }

Constraint files:
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#3}-len.simp.fluxc
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#3}-len.fluxc
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#3}-len.smt2
Fix Information:
  Fix Line: 417
  Helpful Message: n
  Problem Description: 2
  Fix Type: additional_refinement
  Fix Description: count(_, _, cap) < cap
  Certainty: True
  Error Type: 1a
```

The issue here is that `count` is unrefined.

### Ex2: `with_capacity_in`

```
==============================
ERROR: with_capacity_in-L292-0
==============================
Error Message: error[E0999]: refinement type error
   --> src/vec_deque.rs:292:5
    |
292 |     }
    |     ^ a postcondition cannot be proved
    |
note: this is the condition that cannot be proved
   --> src/vec_deque.rs:279:148
    |
279 | ...oc: A) -> VecDeque<T, A>{v: v.head == 0 && v.tail == 0 && capacity <= v.cap})]
    |                                                              ^^^^^^^^^^^^^^^^^


src/vec_deque.rs
279:                 #[flux::sig(fn (capacity: usize{capacity < MAXIMUM_ZST_CAPACITY && capacity > 1}, alloc: A) -> VecDeque<T, A>{v: v.head == 0 && v.tail == 0 && capacity <= v.cap})]
280:                 fn with_capacity_in(capacity: usize, alloc: A) -> VecDeque<T, A> {
281:                     // FLUX-TODO: same as MAXIMUM_ZST_CAPACITY?: assert!(capacity < 1_usize << usize::BITS - 1, "capacity overflow");
282:                     // TODO: Uncomment
283:                     // assert(capacity < MAXIMUM_ZST_CAPACITY);
284:                     // +1 since the ringbuffer always leaves one space empty
285:        fix>         let cap = real_capacity(capacity);
286:             
287:                     VecDeque {
288:                         tail: 0,
289:                         head: 0,
290:                         buf: RawVec::with_capacity_in(cap, alloc),
291:                     }
292: error>          }

Constraint files:
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#3}-with_capacity_in.smt2
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#3}-with_capacity_in.fluxc
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#3}-with_capacity_in.simp.fluxc
Fix Information:
  Fix Line: 285
  Helpful Message: n
  Problem Description: 2
  Fix Type: additional_refinement
  Fix Description: real_capacity(capacity) >= capacity
  Certainty: True
  Error Type: 1a
```

The issue here is that `real_capacity` is unrefined.

### Ex3: enqueue

```
=====================
ERROR: enqueue-L110-0
=====================
Error Message: error[E0999]: refinement type error
   --> kernel/src/collections/ring_buffer.rs:110:13
    |
110 |             false
    |             ^^^^^ a postcondition cannot be proved
    |
note: this is the condition that cannot be proved
   --> kernel/src/collections/ring_buffer.rs:97:76
    |
97  |     #[flux_rs::sig(fn(self: &strg RingBuffer<T>[@old], val: T) -> bool{ b: b == !full(old) }
    |                                                                            ^^^^^^^^^^^^^^^



Constraint files:
  /Users/cole/git/flux-diagnose/ringbuffer-diagnostics/da3a5624b/all_constraints/kernel.collections-ring_buffer-{impl#1}-enqueue.simp.sub.fluxc
  /Users/cole/git/flux-diagnose/ringbuffer-diagnostics/da3a5624b/all_constraints/kernel.collections-ring_buffer-{impl#1}-enqueue.sub.fluxc
  /Users/cole/git/flux-diagnose/ringbuffer-diagnostics/da3a5624b/all_constraints/kernel.collections-ring_buffer-{impl#1}-enqueue.simp.fluxc
  /Users/cole/git/flux-diagnose/ringbuffer-diagnostics/da3a5624b/all_constraints/kernel.collections-ring_buffer-{impl#1}-enqueue.fluxc
  /Users/cole/git/flux-diagnose/ringbuffer-diagnostics/da3a5624b/all_constraints/kernel.collections-ring_buffer-{impl#1}-enqueue.smt2
Fix Information:
  Fix Line: 108
  Helpful Message: n
  Problem Description: 2
  Fix Type: additional_refinement
  Fix Description: is_full needs an annotation
  Certainty: True
  Error Type: 1a
```

The issue here is that `is_full` is unrefined.


## 1b

Postcondition error
Fix is strengthening the precondition on containing function

### Ex1: nearest

(only one example)

```
====================
ERROR: nearest-L75-0
====================
Error Message: error[E0999]: refinement type error
  --> src/kmeans.rs:75:5
   |
75 |     res
   |     ^^^ a postcondition cannot be proved
   |
note: this is the condition that cannot be proved
  --> src/kmeans.rs:58:59
   |
58 |   fn(&RVec<f32>[@n], &RVec<RVec<f32>[n]>[@k]) -> usize{v: v < k}
   |                                                           ^^^^^


src/kmeans.rs
 60:             // requires k > 0
 61:        fix> fn nearest(p: &RVec<f32>, cs: &RVec<RVec<f32>>) -> usize {
 62:                 // let n = p.len();
 63:                 let k = cs.len();
 64:                 let mut res = 0;
 65:                 let mut min = f32::MAX;
 66:                 let mut i = 0;
 67:                 while i < k {
 68:                     let di = dist(&cs[i], p);
 69:                     if di < min {
 70:                         res = i;
 71:                         min = di;
 72:                     }
 73:                     i += 1;
 74:                 }
 75: error>          res
 76:             }

Constraint files:
  /Users/cole/git/flux-diagnose/kmeans-diagnostics/589c0b9/all_constraints/fluxtests.kmeans-nearest.simp.fluxc
  /Users/cole/git/flux-diagnose/kmeans-diagnostics/589c0b9/all_constraints/fluxtests.kmeans-nearest.fluxc
  /Users/cole/git/flux-diagnose/kmeans-diagnostics/589c0b9/all_constraints/fluxtests.kmeans-nearest.smt2
Fix Information:
  Fix Line: 61
  Helpful Message: signature permits k = 0
  Problem Description: 2
  Fix Type: additional_refinement
  Fix Description: k > 0
  Certainty: True
  Error Type: 1b

```

The postcondition is that the result is less than k, which is the
outer dimension of the argument cs. This is ensured by the fact
that the result starts at 0 and is less than k. But if k is 0, then
we could return 0, which violates the condition.

## 2a

Precondition error
Fix is strengthening another function used in the body

### Ex1: `push_back`

```
=======================
ERROR: push_back-L546-0
=======================
Error Message: error[E0999]: assignment might be unsafe
   --> src/vec_deque.rs:546:9
    |
546 |         self.head = self.wrap_add(self.head, 1);
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


src/vec_deque.rs
539:                 //#[stable(feature = "rust1", since = "1.0.0")]
540:                 pub fn push_back(&mut self, value: T) {
541:                     if self.is_full() {
542:                         self.grow();
543:                     }
544:             
545:                     let head = self.head;
546: error> fix>         self.head = self.wrap_add(self.head, 1);
547:                     unsafe { self.buffer_write(head, value) }
548:                 }

Constraint files:
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#3}-push_back.smt2
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#3}-push_back.fluxc
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#3}-push_back.simp.fluxc
Fix Information:
  Fix Line: 546
  Helpful Message: n
  Problem Description: 2
  Fix Type: additional_refinement
  Fix Description: wrap_add needs to preserve vec_deque refinement
  Certainty: True
  Error Type: 2a

```

`wrap_add` isn't refined enough (or at all) to allow for the
invariant on vecdeques to hold when it is called on `self.head`.

### Ex2: `kmeans_step`

```
=========================
ERROR: kmeans_step-L101-1
=========================
Error Message: error[E0999]: refinement type error
   --> src/kmeans.rs:101:9
    |
101 |         add(&mut res_points[j], &ps[i]);
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ a precondition cannot be proved


src/kmeans.rs
 90:             // #[flux::sig(fn(n: usize, k: RVec<RVec<f32>[n]>{k > 0}, &RVec<RVec<f32>[n]>) -> RVec<RVec<f32>[n]>[k])]
 91:             fn kmeans_step(n: usize, cs: RVec<RVec<f32>>, ps: &RVec<RVec<f32>>) -> RVec<RVec<f32>> {
 92:                 let k = cs.len();
 93:             
 94:        fix>     let mut res_points = init_centers(n, k);
 95:             
 96:                 let mut res_size = RVec::from_elem_n(0, k);
 97:             
 98:                 let mut i = 0;
 99:                 while i < ps.len() {
100:                     let j = nearest(&ps[i], &cs);
101: error>              add(&mut res_points[j], &ps[i]);
102:                     res_size[j] += 1;
103:                     i += 1;
104:                 }
105:             
106:                 normalize_centers(n, &mut res_points, &res_size);
107:             
108:                 res_points
109:             }

Constraint files:
  /Users/cole/git/flux-diagnose/kmeans-diagnostics/092a0a1/all_constraints/fluxtests.kmeans-kmeans_step.simp.fluxc
  /Users/cole/git/flux-diagnose/kmeans-diagnostics/092a0a1/all_constraints/fluxtests.kmeans-kmeans_step.fluxc
  /Users/cole/git/flux-diagnose/kmeans-diagnostics/092a0a1/all_constraints/fluxtests.kmeans-kmeans_step.smt2
Fix Information:
  Fix Line: 94
  Helpful Message: n
  Problem Description: 2
  Fix Type: additional_refinement
  Fix Description: res_points and ps need to have same shape
  Certainty: True
  Error Type: 2a
```

`init_centers` isn't refined (enough) to ensure that `res_points`
and `ps` have the same shape. I'm guessing it isn't refined at all.

## 2b

Precondition error
Fix is strengthening the precondition on containing function

### Ex1: `with_capacity`

```
===========================
ERROR: with_capacity-L249-0
===========================
Error Message: error[E0999]: refinement type error
   --> src/vec_deque.rs:249:9
    |
249 |         Self::with_capacity_in(capacity, Global)
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ a precondition cannot be proved
    |
note: this is the condition that cannot be proved
   --> src/vec_deque.rs:279:37
    |
279 |     #[flux::sig(fn (capacity: usize{capacity < MAXIMUM_ZST_CAPACITY && capacity > 1}, alloc: A) -> VecDeque<T, A>{v: v.head == 0 && v.tai...
    |                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


src/vec_deque.rs
247:                 #[must_use]
248:        fix>     pub fn with_capacity(capacity: usize) -> VecDeque<T> {
249: error>              Self::with_capacity_in(capacity, Global)
250:                 }

Constraint files:
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.raw_vec-{impl#0}-with_capacity.fluxc
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#2}-with_capacity.smt2
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.raw_vec-{impl#0}-with_capacity.simp.fluxc
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#2}-with_capacity.fluxc
  /Users/cole/git/flux-diagnose/vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#2}-with_capacity.simp.fluxc
Fix Information:
  Fix Line: 248
  Helpful Message: n
  Problem Description: 2
  Fix Type: additional_refinement
  Fix Description: capacity < MAXIMUM_ZST_CAPACITY
  Certainty: True
  Error Type: 2b
```

The issue here is that the `with_capacity` function is unrefined,
specifically its capacity parameter.

### Ex2: dist

```
=================
ERROR: dist-L13-0
=================
Error Message: error[E0999]: refinement type error
   --> src/kmeans.rs:13:26
    |
13  |         let di = x[i] - y[i];
    |                          ^^^ a precondition cannot be proved
    |
note: this is the condition that cannot be proved
   --> src/rvec.rs:181:44
    |
181 |     #[flux::sig(fn(&RVec<T>[@n], usize{v : v < n}) -> &T)]
    |                                            ^^^^^


src/kmeans.rs
  8:             // #[flux::sig(fn(&RVec<f32>[@n], &RVec<f32>[n]) -> f32)]
  9:        fix> fn dist(x: &RVec<f32>, y: &RVec<f32>) -> f32 {
 10:                 let mut res = 0.0;
 11:                 let mut i = 0;
 12:                 while i < x.len() {
 13: error>              let di = x[i] - y[i];
 14:                     res += di * di;
 15:                     i += 1;
 16:                 }
 17:                 res
 18:             }

Constraint files:
  /Users/cole/git/flux-diagnose/kmeans-diagnostics/5db4630/all_constraints/fluxtests.kmeans-dist.fluxc
  /Users/cole/git/flux-diagnose/kmeans-diagnostics/5db4630/all_constraints/fluxtests.kmeans-dist.smt2
  /Users/cole/git/flux-diagnose/kmeans-diagnostics/5db4630/all_constraints/fluxtests.kmeans-dist.simp.fluxc
Fix Information:
  Fix Line: 9
  Helpful Message: n
  Problem Description: 2
  Fix Type: additional_refinement
  Fix Description: y needs same length as x
  Certainty: True
  Error Type: 2b
```

The issue here is that the parameters on dist are not related to
each other, therefore we can't know that it's safe to index
into y with an index that is safe on x.

### Ex3: RingBuffer new

```
================
ERROR: new-L32-0
================
Error Message: error[E0999]: refinement type error
  --> kernel/src/collections/ring_buffer.rs:32:9
   |
32 | /         RingBuffer {
33 | |             head: 0,
34 | |             tail: 0,
35 | |             ring,
36 | |         }
   | |_________^ a precondition cannot be proved
   |
note: this is the condition that cannot be proved
  --> kernel/src/collections/ring_buffer.rs:13:35
   |
13 |     #[field({&mut [T][ring_len] | ring_len > 1})]
   |                                   ^^^^^^^^^^^^



Constraint files:
  /Users/cole/git/flux-diagnose/ringbuffer-diagnostics/8d22afa18/all_constraints/kernel.collections-ring_buffer-{impl#0}-new.fluxc
  /Users/cole/git/flux-diagnose/ringbuffer-diagnostics/8d22afa18/all_constraints/kernel.collections-ring_buffer-{impl#0}-new.smt2
  /Users/cole/git/flux-diagnose/ringbuffer-diagnostics/8d22afa18/all_constraints/kernel.collections-ring_buffer-{impl#0}-new.simp.fluxc
Fix Information:
  Fix Line: 31
  Helpful Message: n
  Problem Description: 2
  Fix Type: additional_refinement
  Fix Description: len > 1
  Certainty: True
  Error Type: 2b
```

The function new does not have a refinement on the input ring such that its
length is greater than 1.

# Smallest errors

LoC Type Name

17 1a `len-L417-0`
- [fluxc](./vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#3}-len.fluxc)
- [after fix fluxc](./resolved-error-logs/len-L417-0/vecdeque.vec_deque-{impl#3}-len.fluxc)
26 1a `with_capacity_in-L292-0`
- [fluxc](./vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#3}-with_capacity_in.fluxc)
- [after fix fluxc](./resolved-error-logs/with_capacity-L249-0/vecdeque.raw_vec-{impl#0}-with_capacity.fluxc)

12 2b `with_capacity-L249-0` 
- [fluxc](./vecdeque-diagnostics/32162d8/all_constraints/vecdeque.vec_deque-{impl#2}-with_capacity.fluxc)
21 2b `dist-L13-0`
- [fluxc](./kmeans-diagnostics/5db4630/all_constraints/fluxtests.kmeans-dist.fluxc)
22 2b `new-L32-0`
- [fluxc](./ringbuffer-diagnostics/8d22afa18/all_constraints/kernel.collections-ring_buffer-{impl#0}-new.fluxc)
39 2b `kmeans-L117-0`
39 2b `normal-L39-0`

2a and 1b are both >= 90 LoC

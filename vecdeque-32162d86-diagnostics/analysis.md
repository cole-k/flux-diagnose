# `with_capacity` errors

## `capacity < MAXIMUM_ZST_CAPACITY`

### Original error
```
error[E0999]: refinement type error
   --> src/vec_deque.rs:249:9
    |
249 |         Self::with_capacity_in(capacity, Global)
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ a precondition cannot be proved
    |
note: this is the condition that cannot be proved
   --> src/vec_deque.rs:279:37
    |
279 |     #[flux::sig(fn (capacity: usize{capacity < MAXIMUM_ZST_CAPACITY && capacity > 1}, alloc: A) -> VecDeque<T, A>{v: v.head == 0 && v.tail == 0 && capacity <= v.cap})]
    |                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

### Related variables
```
note: related variable `a0` defined here with originator `FnArg(Some("capacity"))`
   --> src/vec_deque.rs:248:26
    |
248 |     pub fn with_capacity(capacity: usize) -> VecDeque<T> {
    |                          ^^^^^^^^
```

### Conclusion
Uniquely identifies the source of the error.

Should be trivial in this case to also suggest the proper refinement because capacity is unrefined.

## `capacity > 1`

### Original error

```
error[E0999]: refinement type error
   --> src/vec_deque.rs:249:9
    |
249 |         Self::with_capacity_in(capacity, Global)
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ a precondition cannot be proved
    |
note: this is the condition that cannot be proved
   --> src/vec_deque.rs:279:72
    |
279 |     #[flux::sig(fn (capacity: usize{capacity < MAXIMUM_ZST_CAPACITY && capacity > 1}, alloc: A) -> VecDeque<T, A>{v: v.head == 0 && v.tail == 0 && capacity <= v.cap})]
    |                                                                        ^^^^^^^^^^^^
```

### Related variables
```
note: related variable `a0` defined here with originator `FnArg(Some("capacity"))`
   --> src/vec_deque.rs:248:26
    |
248 |     pub fn with_capacity(capacity: usize) -> VecDeque<T> {
    |                          ^^^^^^^^
```

### Conclusion
(same as above)

# `with_capacity_in` errors

## `capacity <= v.cap`

### Original error
```
error[E0999]: refinement type error
   --> src/vec_deque.rs:292:5
    |
292 |     }
    |     ^ a postcondition cannot be proved
    |
note: this is the condition that cannot be proved
   --> src/vec_deque.rs:279:148
    |
279 |     #[flux::sig(fn (capacity: usize{capacity < MAXIMUM_ZST_CAPACITY && capacity > 1}, alloc: A) -> VecDeque<T, A>{v: v.head == 0 && v.tail == 0 && capacity <= v.cap})]
    |                                                                                                                                                    ^^^^^^^^^^^^^^^^^
```

### Related variables
```
note: related variable `a1` defined here with originator `CallReturn`
   --> src/vec_deque.rs:285:19
    |
285 |         let cap = real_capacity(capacity);
    |                   ^^^^^^^^^^^^^^^^^^^^^^^
```

### Conclusion

Another case where the location is unique and we identify the culprit appropriately.

In this case, because its origin is a `CallReturn`, we should blame the function defn.

Interestingly, function _does_ have a signature and it is

```
#[flux::sig(fn(capacity: usize) -> usize{v: v >= 1 && pow2(v)})]
fn real_capacity(capacity: usize) -> usize {
```

Note that it _does not_ mention `capacity` in the return, which is the bug. If
it mentioned `capacity` in its return type, then we would additionally blame
the argument `capacity` in `with_capacity_in`. So the bug in this case makes
finding the blame easy.

It is possible that again in this case propagating the refinement is easy!


# `len` errors

## `v < self.cap`

### Original error
```
error[E0999]: refinement type error
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
```

### Related variables
```
note: related variable `a1` defined here with originator `CallReturn`
   --> src/vec_deque.rs:417:9
    |
417 |         count(self.tail, self.head, self.cap())
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

### Conclusion

Another case where there is only one variable, so the blame is unique.

Another `CallReturn` as well, which indicates we should blame the defn of
`count`.

In this case, `count` is unrefined, so propagating the refinement back should
suffice.

N.B. there is a call to `self.cap()` that does not appear. Why? Because the
unrefined `count` "swallows" the call to it.

If you give `count` an _incorrect_ annotation, such as

```
#[flux::sig(fn(tail: usize, head: usize, size: Size) -> usize{v: v <= size})]
fn count(tail: usize, head: usize, size: Size) -> usize {
```

Then we in theory will report the call to `self.cap()`. BUT we actually are
able to skip blaming `self.cap()` in this case! Why? Look at the signature:

```
    #[flux::sig(fn (&VecDeque<T,A>[@self]) -> Size{v: v == self.cap})]
    fn cap(&self) -> Size {
```

because its output is just equal to `self.cap` (no more and no less), Flux will
simplify the constraint and replace the variable used for the call to
`self.cap()` with the variable corresponding to the capacity. NOTE: this is
only true if we have `Size` indexed by `self.cap`.

NOTE: do we actually want to lose this source of blame? Nico argued that if the
output is an index, then it cannot be any more precise. But what about
`Size[self.cap] ensures self.cap > 0`? Theoretically a function could do this?
Would any?


# `push_front` errors

## `self.tail` assignment

### Original error
```
error[E0999]: assignment might be unsafe
   --> src/vec_deque.rs:520:9
    |
520 |         self.tail = self.wrap_sub(tail, 1);
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

### Related variables
```
note: related variable `a2` defined here with originator `CallReturn`
   --> src/vec_deque.rs:515:12
    |
515 |         if self.is_full() {
    |            ^^^^^^^^^^^^^^
note: related variable `a0` defined here with originator `FnArg(Some("value"))`
   --> src/vec_deque.rs:514:34
    |
514 |     pub fn push_front(&mut self, value: T) {
    |                                  ^^^^^
note: related variable `a4` defined here with originator `CallReturn`
   --> src/vec_deque.rs:520:21
    |
520 |         self.tail = self.wrap_sub(tail, 1);
    |                     ^^^^^^^^^^^^^^^^^^^^^^
```

### Conclusion
I checked the constraint and these appear to be bogus related variables except for `a3`.

```
(a0: FnArg(Some(\"value\"))), (a1: No provenance), (a2: CallReturn), (a4: CallReturn), (a3: No provenance)
```

The failing constraint in question is essentially a requirement that the return
value of `self.wrap_sub(tail, 1)` meet the vecdeque invariant. Note that
`wrap_sub` is unrefined. The actual constraint is that `a4 = a3.2` where
`a3.2` is the tail value of `self`.

```
          ∀ a3: VecDeque.
            ($k1(a3.0, a3.1, a3.2) ∧ a3.1 < a3.2 ∧ a3.1 ≥ 0 ∧ a3.0 < a3.2 ∧ a3.0 ≥ 0 ∧ pow2(a3.2) ∧ 1 ≤ a3.2) =>
              ∀ a4: T::sort ~ Sub(Call) at 520:21: 520:43. $k4(a4) ~ Call at 520:21: 520:43
              ∀ a4: int ~ CallReturn at 520:21: 520:43.
                (a4 ≥ 0 ∧ a3.1 < a3.2 ∧ a3.1 ≥ 0 ∧ a3.0 < a3.2 ∧ a3.0 ≥ 0 ∧ pow2(a3.2) ∧ 1 ≤ a3.2) =>
fail here ->      (a4 = a3.1) ~ Assign at 520:9: 520:43
                  ∀ a5: T::sort ~ Sub(Call) at 523:13: 523:43. $k5(a5) ~ Call at 523:13: 523:43
                  ∀ a5: VecDeque ~ Sub(Call) at 523:13: 523:43. (a5 = a3) ~ Call at 523:13: 523:43
                  $k5(a0) ~ Call at 523:13: 523:43
```

In this case, we should be able to uniquely blame `wrap_sub` for not preserving
the vecdeque invariant, like in e.g. the `with_capacity_in` case.


## `buffer_write` error

### Original error
```
error[E0999]: refinement type error
   --> src/vec_deque.rs:523:13
    |
523 |             self.buffer_write(tail, value);
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ a precondition cannot be proved
```

### Related variables
```
note: related variable `a2` defined here with originator `CallReturn`
   --> src/vec_deque.rs:515:12
    |
515 |         if self.is_full() {
    |            ^^^^^^^^^^^^^^
note: related variable `a0` defined here with originator `FnArg(Some("value"))`
   --> src/vec_deque.rs:514:34
    |
514 |     pub fn push_front(&mut self, value: T) {
    |                                  ^^^^^
note: related variable `a5` defined here with originator `Sub(Call)`
   --> src/vec_deque.rs:523:13
    |
523 |             self.buffer_write(tail, value);
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

### Conclusion

I'm pretty sure that the `a2` variable here is bogus, like above.

Here are the other related variables

```
`"(a0: FnArg(Some(\"value\"))), (a1: No provenance), (a2: CallReturn), (a5: Sub(Call)), (a3: No provenance)"`
```

I honestly don't know what's going on here. I'm pretty sure the issue is caused
by `self.buffer_write()` not being refined. 

When I refine it, the relvant part of the constraint becomes the below. Note
that the line numbers jump up by 2 because I added a refinement.

```
          ∀ a3: VecDeque.
            ($k1(a3.0, a3.1, a3.2) ∧ a3.1 < a3.2 ∧ a3.1 ≥ 0 ∧ a3.0 < a3.2 ∧ a3.0 ≥ 0 ∧ pow2(a3.2) ∧ 1 ≤ a3.2) =>
              ∀ a4: T::sort ~ Sub(Call) at 522:21: 522:43. $k4(a4) ~ Call at 522:21: 522:43
              ∀ a4: int ~ CallReturn at 522:21: 522:43.
                (a4 ≥ 0 ∧ a3.1 < a3.2 ∧ a3.1 ≥ 0 ∧ a3.0 < a3.2 ∧ a3.0 ≥ 0 ∧ pow2(a3.2) ∧ 1 ≤ a3.2) =>
                  (a4 = a3.1) ~ Assign at 522:9: 522:43
                  ∀ a5: T::sort ~ Sub(Call) at 525:13: 525:43. $k5(a5) ~ Call at 525:13: 525:43
                  (a3.1 < a3.2) ~ Call at 525:13: 525:43
                  $k5(a0) ~ Call at 525:13: 525:43
```


# `push_back` errors

There are two identical errors to `push_front` here.

---

# Uninvestigated errors
```
error[E0999]: type invariant may not hold (when place is folded)
   --> src/vec_deque.rs:559:9
    |
559 |         self.buf.reserve_exact(old_cap, old_cap);
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

error[E0999]: there is an error with related variables `"(a0: No provenance), (a2: No provenance), (a1: CallReturn)"`
   --> src/vec_deque.rs:559:9
    |
559 |         self.buf.reserve_exact(old_cap, old_cap);
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
note: related variable `a1` defined here with originator `CallReturn`
   --> src/vec_deque.rs:558:23
    |
558 |         let old_cap = self.cap();
    |                       ^^^^^^^^^^

error[E0999]: refinement type error
   --> src/vec_deque.rs:563:9
    |
563 |         assert(new_cap == old_cap * 2);
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ a precondition cannot be proved
    |
note: this is the condition that cannot be proved
   --> src/vec_deque.rs:598:21
    |
598 | #[flux::sig(fn(bool[true]))]
    |                     ^^^^

error[E0999]: there is an error with related variables `"(a2: No provenance), (a0: No provenance), (a4: CallReturn), (a1: CallReturn)"`
   --> src/vec_deque.rs:563:9
    |
563 |         assert(new_cap == old_cap * 2);
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
note: related variable `a4` defined here with originator `CallReturn`
   --> src/vec_deque.rs:561:23
    |
561 |         let new_cap = self.cap();
    |                       ^^^^^^^^^^
note: related variable `a1` defined here with originator `CallReturn`
   --> src/vec_deque.rs:558:23
    |
558 |         let old_cap = self.cap();
    |                       ^^^^^^^^^^

error[E0999]: refinement type error
   --> src/vec_deque.rs:565:13
    |
565 |             self.handle_capacity_increase(old_cap);
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ a precondition cannot be proved
    |
note: this is the condition that cannot be proved
   --> src/vec_deque.rs:171:75
    |
171 |     #[flux::sig(fn (self: &strg VecDeque<T,A>[@s], old_capacity: usize{v: v * 2 <= s.cap && s.tail < v}) ensures self: VecDeque<T, A>)]
    |                                                                           ^^^^^^^^^^^^^^

error[E0999]: there is an error with related variables `"(a4: CallReturn), (a0: No provenance), (a2: No provenance), (a1: CallReturn)"`
   --> src/vec_deque.rs:565:13
    |
565 |             self.handle_capacity_increase(old_cap);
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
note: related variable `a4` defined here with originator `CallReturn`
   --> src/vec_deque.rs:561:23
    |
561 |         let new_cap = self.cap();
    |                       ^^^^^^^^^^
note: related variable `a1` defined here with originator `CallReturn`
   --> src/vec_deque.rs:558:23
    |
558 |         let old_cap = self.cap();
    |                       ^^^^^^^^^^

error[E0999]: refinement type error
   --> src/vec_deque.rs:565:13
    |
565 |             self.handle_capacity_increase(old_cap);
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ a precondition cannot be proved
    |
note: this is the condition that cannot be proved
   --> src/vec_deque.rs:171:94
    |
171 |     #[flux::sig(fn (self: &strg VecDeque<T,A>[@s], old_capacity: usize{v: v * 2 <= s.cap && s.tail < v}) ensures self: VecDeque<T, A>)]
    |                                                                                              ^^^^^^^^^

error[E0999]: there is an error with related variables `"(a0: No provenance), (a4: CallReturn), (a1: CallReturn), (a2: No provenance)"`
   --> src/vec_deque.rs:565:13
    |
565 |             self.handle_capacity_increase(old_cap);
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
note: related variable `a4` defined here with originator `CallReturn`
   --> src/vec_deque.rs:561:23
    |
561 |         let new_cap = self.cap();
    |                       ^^^^^^^^^^
note: related variable `a1` defined here with originator `CallReturn`
   --> src/vec_deque.rs:558:23
    |
558 |         let old_cap = self.cap();
    |                       ^^^^^^^^^^

error[E0999]: type invariant may not hold (when place is folded)
   --> src/vec_deque.rs:565:13
    |
565 |             self.handle_capacity_increase(old_cap);
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

error[E0999]: there is an error with related variables `"(a4: CallReturn), (a6: AssumeEnsures), (a2: No provenance)"`
   --> src/vec_deque.rs:565:13
    |
565 |             self.handle_capacity_increase(old_cap);
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
note: related variable `a4` defined here with originator `CallReturn`
   --> src/vec_deque.rs:561:23
    |
561 |         let new_cap = self.cap();
    |                       ^^^^^^^^^^
note: related variable `a6` defined here with originator `AssumeEnsures`
   --> src/vec_deque.rs:565:13
    |
565 |             self.handle_capacity_increase(old_cap);
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

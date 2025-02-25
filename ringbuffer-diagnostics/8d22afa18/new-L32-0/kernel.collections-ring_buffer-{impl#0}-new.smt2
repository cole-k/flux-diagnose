;; Tag 0: Call at 32:9: 36:10
;; Tag 1: Call at 32:9: 36:10
;; Tag 2: Call at 32:9: 36:10

(qualif EqZero ((v int)) ((= v 0)))
(qualif GtZero ((v int)) ((> v 0)))
(qualif GeZero ((v int)) ((>= v 0)))
(qualif LtZero ((v int)) ((< v 0)))
(qualif LeZero ((v int)) ((<= v 0)))
(qualif Eq ((a int) (b int)) ((= a b)))
(qualif Gt ((a int) (b int)) ((> a b)))
(qualif Ge ((a int) (b int)) ((>= a b)))
(qualif Lt ((a int) (b int)) ((< a b)))
(qualif Le ((a int) (b int)) ((<= a b)))
(qualif Le1 ((a int) (b int)) ((<= a (- b 1))))
(constant gt (func 1 (@(0) @(0) ) bool))
(constant ge (func 1 (@(0) @(0) ) bool))
(constant lt (func 1 (@(0) @(0) ) bool))
(constant le (func 1 (@(0) @(0) ) bool))
(var $k0 (int int)) ;; orig: $k0

(constraint
 (forall ((a0 int) (true))
  (and
   (tag ((> a0 1)) "0")
   (forall ((a1 int) (true))
    ($k0 a1 a0))
   (tag ((< 0 a0)) "1")
   (tag ((< 0 a0)) "2")
   (forall ((a2 int) (true))
    ($k0 a2 a0)))))


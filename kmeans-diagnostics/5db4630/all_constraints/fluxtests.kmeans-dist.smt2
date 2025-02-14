;; Tag 0: Call at 13:19: 13:22
;; Tag 1: Call at 13:26: 13:29

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
(var $k0 (int int int)) ;; orig: $k0

(constraint
 (forall ((a0 int) (true))
  (forall ((_$ int) ((<= 0 a0)))
   (forall ((a1 int) (true))
    (forall ((_$ int) ((<= 0 a1)))
     (and
      (forall ((a2 int) ((= a2 0)))
       ($k0 a2 a0 a1))
      (forall ((a3 int) (true))
       (forall ((_$ int) ($k0 a3 a0 a1))
        (forall ((_$ int) ((>= a0 0)))
         (forall ((_$ int) ((< a3 a0)))
          (and
           (tag ((< a3 a0)) "0")
           (tag ((< a3 a1)) "1")
           (forall ((a4 int) ((= a4 (+ a3 1))))
            ($k0 a4 a0 a1)))))))))))))


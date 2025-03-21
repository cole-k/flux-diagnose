;; Tag 0: Call at 586:5: 586:46
;; Tag 1: Call at 586:5: 586:46

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
(constant c0 (func 0 (int ) bool))  ;; uif: pow2
(constant gt (func 1 (@(0) @(0) ) bool))
(constant ge (func 1 (@(0) @(0) ) bool))
(constant lt (func 1 (@(0) @(0) ) bool))
(constant le (func 1 (@(0) @(0) ) bool))

(constraint
 (forall ((a0 int) (true))
  (forall ((_$ int) ((>= a0 0)))
   (forall ((a1 int) (true))
    (forall ((_$ int) ((>= a1 0)))
     (forall ((a2 int) (true))
      (forall ((_$ int) (and ((c0 a2)) ((<= 1 a2))))
       (forall ((_$ int) ((>= a2 0)))
        (forall ((a3 int) (true))
         (forall ((_$ int) ((>= a3 0)))
          (and
           (tag ((c0 a2)) "0")
           (tag ((<= 1 a2)) "1"))))))))))))


;; Tag 0: Overflow at 364:9: 364:23

(datatype (Tuple3 3) ((mktuple3 ((tuple3$0 @(0)) (tuple3$1 @(1)) (tuple3$2 @(2))))))
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
(var $k0 (int int int int)) ;; orig: $k0

(constraint
 (forall ((a0 (Tuple3 int int int)) (true))
  (and
   (forall ((a1 int) (true))
    (forall ((a2 int) ((= a2 (tuple3$0 a0))))
     (forall ((a3 int) ((= a3 (tuple3$1 a0))))
      (forall ((a4 int) ((= a4 (tuple3$2 a0))))
       ($k0 a1 a2 a3 a4)))))
   (forall ((a5 int) (true))
    (forall ((_$ int) ((= a5 (tuple3$2 a0))))
     (forall ((_$ int) (and ((c0 a5)) ((<= 1 a5))))
      (forall ((_$ int) ((>= a5 0)))
       (tag ((>= (- a5 1) 0)) "0"))))))))


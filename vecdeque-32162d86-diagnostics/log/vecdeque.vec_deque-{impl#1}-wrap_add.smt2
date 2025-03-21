;; Tag 0: Call at 130:9: 130:57
;; Tag 1: Call at 130:9: 130:57

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
(var $k0 (int int int int int int int)) ;; orig: $k0

(constraint
 (forall ((a0 (Tuple3 int int int)) (true))
  (forall ((a1 int) (true))
   (forall ((_$ int) ((>= a1 0)))
    (forall ((a2 int) (true))
     (forall ((_$ int) ((>= a2 0)))
      (forall ((a3 int) (true))
       (forall ((_$ int) ((>= a3 0)))
        (and
         (forall ((a4 int) (true))
          (forall ((a5 int) ((= a5 (tuple3$0 a0))))
           (forall ((a6 int) ((= a6 (tuple3$1 a0))))
            (forall ((a7 int) ((= a7 (tuple3$2 a0))))
             ($k0 a4 a5 a6 a7 a1 a2 a3)))))
         (forall ((a8 int) (true))
          (forall ((_$ int) ((= a8 (tuple3$2 a0))))
           (forall ((_$ int) (and ((c0 a8)) ((<= 1 a8))))
            (forall ((_$ int) ((>= a8 0)))
             (and
              (tag ((c0 a8)) "0")
              (tag ((<= 1 a8)) "1")))))))))))))))


;; Tag 0: Assert("possible remainder with a divisor of zero") at 82:22: 82:57
;; Tag 1: Ret at 82:9: 82:57

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
(constant gt (func 1 (@(0) @(0) ) bool))
(constant ge (func 1 (@(0) @(0) ) bool))
(constant lt (func 1 (@(0) @(0) ) bool))
(constant le (func 1 (@(0) @(0) ) bool))
(var $k0 (int int int int)) ;; orig: $k0

(constraint
 (forall ((reftgen$rb$0 (Tuple3 int int int)) (true))
  (forall ((_$ int) ((> (tuple3$0 reftgen$rb$0) 1)))
   (forall ((_$ int) ((> (tuple3$0 reftgen$rb$0) 1)))
    (forall ((_$ int) ((>= (tuple3$0 reftgen$rb$0) 0)))
     (forall ((_$ int) ((< (tuple3$1 reftgen$rb$0) (tuple3$0 reftgen$rb$0))))
      (forall ((_$ int) ((>= (tuple3$1 reftgen$rb$0) 0)))
       (forall ((_$ int) ((< (tuple3$2 reftgen$rb$0) (tuple3$0 reftgen$rb$0))))
        (forall ((_$ int) ((>= (tuple3$2 reftgen$rb$0) 0)))
         (and
          (forall ((a0 int) (true))
           (forall ((a1 int) ((= a1 (tuple3$0 reftgen$rb$0))))
            (forall ((a2 int) ((= a2 (tuple3$1 reftgen$rb$0))))
             (forall ((a3 int) ((= a3 (tuple3$2 reftgen$rb$0))))
              ($k0 a0 a1 a2 a3)))))
          (forall ((_$ int) ((>= (tuple3$0 reftgen$rb$0) 0)))
           (and
            (tag ((!= (tuple3$0 reftgen$rb$0) 0)) "0")
            (forall ((_$ int) ((!= (tuple3$0 reftgen$rb$0) 0)))
             (tag ((= (tuple3$1 reftgen$rb$0) (mod (+ (tuple3$2 reftgen$rb$0) 1) (tuple3$0 reftgen$rb$0)))) "1"))))))))))))))


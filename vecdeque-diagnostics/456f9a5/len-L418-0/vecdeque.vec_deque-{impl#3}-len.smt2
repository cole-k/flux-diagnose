;; Tag 0: Call at 418:9: 418:48
;; Tag 1: Call at 418:9: 418:48
;; Tag 2: Ret at 418:9: 418:48

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
 (forall ((reftgen$self$0 (Tuple3 int int int)) (true))
  (forall ((_$ int) ((< (tuple3$1 reftgen$self$0) (tuple3$2 reftgen$self$0))))
   (forall ((_$ int) ((>= (tuple3$1 reftgen$self$0) 0)))
    (forall ((_$ int) ((< (tuple3$0 reftgen$self$0) (tuple3$2 reftgen$self$0))))
     (forall ((_$ int) ((>= (tuple3$0 reftgen$self$0) 0)))
      (forall ((_$ int) (and ((c0 (tuple3$2 reftgen$self$0))) ((<= 1 (tuple3$2 reftgen$self$0)))))
       (and
        (forall ((a0 int) (true))
         (forall ((a1 int) ((= a1 (tuple3$0 reftgen$self$0))))
          (forall ((a2 int) ((= a2 (tuple3$1 reftgen$self$0))))
           (forall ((a3 int) ((= a3 (tuple3$2 reftgen$self$0))))
            ($k0 a0 a1 a2 a3)))))
        (forall ((a4 int) (true))
         (forall ((_$ int) ((= a4 (tuple3$2 reftgen$self$0))))
          (forall ((_$ int) (and ((c0 a4)) ((<= 1 a4))))
           (forall ((_$ int) ((>= a4 0)))
            (and
             (and
              (tag ((c0 a4)) "0")
              (tag ((<= 1 a4)) "1"))
             (forall ((a5 int) (true))
              (forall ((_$ int) ((<= a5 a4)))
               (forall ((_$ int) ((>= a5 0)))
                (tag ((< a5 (tuple3$2 reftgen$self$0))) "2")))))))))))))))))


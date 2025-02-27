;; Tag 0: Call at 250:9: 250:49
;; Tag 1: Call at 250:9: 250:49
;; Tag 2: Ret at 250:42: 250:48
;; Tag 3: Ret at 250:42: 250:48
;; Tag 4: Ret at 250:42: 250:48

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
(constant c0 int)  ;; rust const: vec_deque::MAXIMUM_ZST_CAPACITY Some(9223372036854775808)
(constant gt (func 1 (@(0) @(0) ) bool))
(constant ge (func 1 (@(0) @(0) ) bool))
(constant lt (func 1 (@(0) @(0) ) bool))
(constant le (func 1 (@(0) @(0) ) bool))

(constraint
 (forall ((_$ int) ((= c0 9223372036854775808)))
  (forall ((reftgen$capacity$0 int) (true))
   (forall ((_$ int) (and ((< reftgen$capacity$0 c0)) ((> reftgen$capacity$0 1))))
    (forall ((_$ int) ((>= reftgen$capacity$0 0)))
     (and
      (and
       (tag ((< reftgen$capacity$0 c0)) "0")
       (tag ((> reftgen$capacity$0 1)) "1"))
      (forall ((a0 (Tuple3 int int int)) (true))
       (forall ((_$ int) (and ((= (tuple3$0 a0) 0)) ((= (tuple3$1 a0) 0)) ((<= reftgen$capacity$0 (tuple3$2 a0)))))
        (and
         (tag ((= (tuple3$0 a0) 0)) "2")
         (tag ((= (tuple3$1 a0) 0)) "3")
         (tag ((<= reftgen$capacity$0 (tuple3$2 a0))) "4"))))))))))


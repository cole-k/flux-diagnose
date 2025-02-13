;; Tag 0: Call at 288:9: 292:10
;; Tag 1: Call at 288:9: 292:10
;; Tag 2: Call at 288:9: 292:10
;; Tag 3: Call at 288:9: 292:10
;; Tag 4: Ret at 293:5: 293:6

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
(constant c1 (func 0 (int ) bool))  ;; uif: pow2
(constant gt (func 1 (@(0) @(0) ) bool))
(constant ge (func 1 (@(0) @(0) ) bool))
(constant lt (func 1 (@(0) @(0) ) bool))
(constant le (func 1 (@(0) @(0) ) bool))
(var $k0 (int int int int)) ;; orig: $k0
(var $k1 (int int int int)) ;; orig: $k1

(constraint
 (forall ((_$ int) ((= c0 9223372036854775808)))
  (forall ((reftgen$capacity$0 int) (true))
   (forall ((_$ int) (and ((< reftgen$capacity$0 c0)) ((> reftgen$capacity$0 1))))
    (forall ((_$ int) ((>= reftgen$capacity$0 0)))
     (forall ((a0 int) (true))
      (forall ((a1 int) (true))
       (forall ((_$ int) (and ((>= a1 1)) ((c1 a1))))
        (forall ((_$ int) ((>= a1 0)))
         (and
          (tag ((< 0 a1)) "0")
          (tag ((< 0 a1)) "1")
          (and
           (tag ((c1 a1)) "2")
           (tag ((<= 1 a1)) "3"))
          (forall ((a2 int) (true))
           (forall ((_$ int) ($k0 a2 reftgen$capacity$0 a0 a1))
            ($k1 a2 reftgen$capacity$0 a0 a1)))
          (tag ((<= reftgen$capacity$0 a1)) "4")))))))))))


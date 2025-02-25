;; Tag 0: Ret at 158:13: 158:17
;; Tag 1: Ret at 158:13: 158:17
;; Tag 2: Assert("possible out-of-bounds access") at 154:23: 154:43
;; Tag 3: Assert("possible remainder with a divisor of zero") at 155:25: 155:58
;; Tag 4: Fold at 156:13: 156:22
;; Tag 5: Fold at 156:13: 156:22
;; Tag 6: Fold at 156:13: 156:22
;; Tag 7: Ret at 156:13: 156:22
;; Tag 8: Ret at 156:13: 156:22

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
(var $k1 (int int int int bool int)) ;; orig: $k2
(var $k2 (int int int int bool int)) ;; orig: $k3
(var $k3 (int int int int bool int)) ;; orig: $k4

(constraint
 (forall ((reftgen$old$1 (Tuple3 int int int)) (true))
  (forall ((_$ int) ((> (tuple3$0 reftgen$old$1) 1)))
   (and
    (forall ((a0 int) (true))
     (forall ((a1 int) ((= a1 (tuple3$0 reftgen$old$1))))
      (forall ((a2 int) ((= a2 (tuple3$1 reftgen$old$1))))
       (forall ((a3 int) ((= a3 (tuple3$2 reftgen$old$1))))
        ($k0 a0 a1 a2 a3)))))
    (forall ((a4 bool) (true))
     (and
      (forall ((_$ int) ((not a4)))
       (and
        (tag ((= false (!= (tuple3$1 reftgen$old$1) (tuple3$2 reftgen$old$1)))) "0")
        (tag ((if (= (tuple3$1 reftgen$old$1) (tuple3$2 reftgen$old$1)) (= reftgen$old$1 reftgen$old$1) (and (and (= (tuple3$0 reftgen$old$1) (tuple3$0 reftgen$old$1)) (= (tuple3$2 reftgen$old$1) (tuple3$2 reftgen$old$1))) (= (tuple3$1 reftgen$old$1) (mod (+ (tuple3$1 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)))))) "1")))
      (forall ((_$ int) (a4))
       (forall ((_$ int) ((> (tuple3$0 reftgen$old$1) 1)))
        (forall ((_$ int) ((>= (tuple3$0 reftgen$old$1) 0)))
         (forall ((_$ int) ((< (tuple3$1 reftgen$old$1) (tuple3$0 reftgen$old$1))))
          (forall ((_$ int) ((>= (tuple3$1 reftgen$old$1) 0)))
           (forall ((_$ int) ((< (tuple3$2 reftgen$old$1) (tuple3$0 reftgen$old$1))))
            (forall ((_$ int) ((>= (tuple3$2 reftgen$old$1) 0)))
             (and
              (tag ((< (tuple3$1 reftgen$old$1) (tuple3$0 reftgen$old$1))) "2")
              (forall ((_$ int) ((< (tuple3$1 reftgen$old$1) (tuple3$0 reftgen$old$1))))
               (forall ((a5 int) (true))
                (and
                 (forall ((a6 int) (true))
                  (forall ((a7 int) ((= a7 (tuple3$0 reftgen$old$1))))
                   (forall ((a8 int) ((= a8 (tuple3$1 reftgen$old$1))))
                    (forall ((a9 int) ((= a9 (tuple3$2 reftgen$old$1))))
                     ($k1 a6 a7 a8 a9 a4 a5)))))
                 (forall ((_$ int) ((>= (tuple3$0 reftgen$old$1) 0)))
                  (and
                   (tag ((!= (tuple3$0 reftgen$old$1) 0)) "3")
                   (forall ((_$ int) ((!= (tuple3$0 reftgen$old$1) 0)))
                    (and
                     (forall ((a10 int) ((= a10 (tuple3$0 reftgen$old$1))))
                      (forall ((a11 int) ((= a11 (tuple3$1 reftgen$old$1))))
                       (forall ((a12 int) ((= a12 (tuple3$2 reftgen$old$1))))
                        ($k2 a5 a10 a11 a12 a4 a5))))
                     (tag ((> (tuple3$0 reftgen$old$1) 1)) "4")
                     (forall ((a13 int) (true))
                      (forall ((a14 int) ((= a14 (tuple3$0 reftgen$old$1))))
                       (forall ((a15 int) ((= a15 (tuple3$1 reftgen$old$1))))
                        (forall ((a16 int) ((= a16 (tuple3$2 reftgen$old$1))))
                         ($k3 a13 a14 a15 a16 a4 a5)))))
                     (tag ((< (mod (+ (tuple3$1 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)) (tuple3$0 reftgen$old$1))) "5")
                     (tag ((< (tuple3$2 reftgen$old$1) (tuple3$0 reftgen$old$1))) "6")
                     (tag ((= true (!= (tuple3$1 reftgen$old$1) (tuple3$2 reftgen$old$1)))) "7")
                     (tag ((if (= (tuple3$1 reftgen$old$1) (tuple3$2 reftgen$old$1)) (= reftgen$old$1 (mktuple3 (tuple3$0 reftgen$old$1) (mod (+ (tuple3$1 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)) (tuple3$2 reftgen$old$1))) (and (and (= (tuple3$0 reftgen$old$1) (tuple3$0 reftgen$old$1)) (= (tuple3$2 reftgen$old$1) (tuple3$2 reftgen$old$1))) (= (mod (+ (tuple3$1 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)) (mod (+ (tuple3$1 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)))))) "8")
                     (forall ((a17 int) (true))
                      (forall ((a18 int) ((= a18 (tuple3$0 reftgen$old$1))))
                       (forall ((a19 int) ((= a19 (tuple3$1 reftgen$old$1))))
                        (forall ((a20 int) ((= a20 (tuple3$2 reftgen$old$1))))
                         ($k3 a17 a18 a19 a20 a4 a5))))))))))))))))))))))))))


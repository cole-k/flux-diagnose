;; Tag 0: Assert("possible out-of-bounds access") at 112:13: 112:33
;; Tag 1: Assert("possible remainder with a divisor of zero") at 113:25: 113:58
;; Tag 2: Fold at 114:13: 114:17
;; Tag 3: Fold at 114:13: 114:17
;; Tag 4: Fold at 114:13: 114:17
;; Tag 5: Ret at 114:13: 114:17
;; Tag 6: Ret at 114:13: 114:17
;; Tag 7: Ret at 110:13: 110:18
;; Tag 8: Ret at 110:13: 110:18

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
(var $k0 (int int int int int)) ;; orig: $k0
(var $k1 (int int int int int)) ;; orig: $k1
(var $k2 (int int int int int)) ;; orig: $k2

(constraint
 (forall ((reftgen$old$1 (Tuple3 int int int)) (true))
  (forall ((_$ int) ((> (tuple3$0 reftgen$old$1) 1)))
   (forall ((a0 int) (true))
    (and
     (forall ((a1 int) (true))
      (forall ((a2 int) ((= a2 (tuple3$0 reftgen$old$1))))
       (forall ((a3 int) ((= a3 (tuple3$1 reftgen$old$1))))
        (forall ((a4 int) ((= a4 (tuple3$2 reftgen$old$1))))
         ($k0 a1 a2 a3 a4 a0)))))
     (forall ((_$ int) ((!= (tuple3$1 reftgen$old$1) (mod (+ (tuple3$2 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)))))
      (forall ((_$ int) ((> (tuple3$0 reftgen$old$1) 1)))
       (forall ((_$ int) ((>= (tuple3$0 reftgen$old$1) 0)))
        (forall ((_$ int) ((< (tuple3$1 reftgen$old$1) (tuple3$0 reftgen$old$1))))
         (forall ((_$ int) ((>= (tuple3$1 reftgen$old$1) 0)))
          (forall ((_$ int) ((< (tuple3$2 reftgen$old$1) (tuple3$0 reftgen$old$1))))
           (forall ((_$ int) ((>= (tuple3$2 reftgen$old$1) 0)))
            (and
             (tag ((< (tuple3$2 reftgen$old$1) (tuple3$0 reftgen$old$1))) "0")
             (forall ((_$ int) ((< (tuple3$2 reftgen$old$1) (tuple3$0 reftgen$old$1))))
              (and
               (forall ((a5 int) (true))
                (forall ((a6 int) ((= a6 (tuple3$0 reftgen$old$1))))
                 (forall ((a7 int) ((= a7 (tuple3$1 reftgen$old$1))))
                  (forall ((a8 int) ((= a8 (tuple3$2 reftgen$old$1))))
                   ($k1 a5 a6 a7 a8 a0)))))
               (forall ((_$ int) ((>= (tuple3$0 reftgen$old$1) 0)))
                (and
                 (tag ((!= (tuple3$0 reftgen$old$1) 0)) "1")
                 (forall ((_$ int) ((!= (tuple3$0 reftgen$old$1) 0)))
                  (and
                   (tag ((> (tuple3$0 reftgen$old$1) 1)) "2")
                   (forall ((a9 int) (true))
                    (forall ((a10 int) ((= a10 (tuple3$0 reftgen$old$1))))
                     (forall ((a11 int) ((= a11 (tuple3$1 reftgen$old$1))))
                      (forall ((a12 int) ((= a12 (tuple3$2 reftgen$old$1))))
                       ($k2 a9 a10 a11 a12 a0)))))
                   (tag ((< (tuple3$1 reftgen$old$1) (tuple3$0 reftgen$old$1))) "3")
                   (tag ((< (mod (+ (tuple3$2 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)) (tuple3$0 reftgen$old$1))) "4")
                   (tag ((= true (!= (tuple3$1 reftgen$old$1) (mod (+ (tuple3$2 reftgen$old$1) 1) (tuple3$0 reftgen$old$1))))) "5")
                   (tag ((if (= (tuple3$1 reftgen$old$1) (mod (+ (tuple3$2 reftgen$old$1) 1) (tuple3$0 reftgen$old$1))) (= reftgen$old$1 (mktuple3 (tuple3$0 reftgen$old$1) (tuple3$1 reftgen$old$1) (mod (+ (tuple3$2 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)))) (and (and (= (tuple3$0 reftgen$old$1) (tuple3$0 reftgen$old$1)) (= (tuple3$1 reftgen$old$1) (mod (+ (tuple3$1 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)))) (= (mod (+ (tuple3$2 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)) (mod (+ (tuple3$2 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)))))) "6")
                   (forall ((a13 int) (true))
                    (forall ((a14 int) ((= a14 (tuple3$0 reftgen$old$1))))
                     (forall ((a15 int) ((= a15 (tuple3$1 reftgen$old$1))))
                      (forall ((a16 int) ((= a16 (tuple3$2 reftgen$old$1))))
                       ($k2 a13 a14 a15 a16 a0)))))))))))))))))))
     (forall ((_$ int) ((not (!= (tuple3$1 reftgen$old$1) (mod (+ (tuple3$2 reftgen$old$1) 1) (tuple3$0 reftgen$old$1))))))
      (and
       (tag ((= false (!= (tuple3$1 reftgen$old$1) (mod (+ (tuple3$2 reftgen$old$1) 1) (tuple3$0 reftgen$old$1))))) "7")
       (tag ((if (= (tuple3$1 reftgen$old$1) (mod (+ (tuple3$2 reftgen$old$1) 1) (tuple3$0 reftgen$old$1))) (= reftgen$old$1 reftgen$old$1) (and (and (= (tuple3$0 reftgen$old$1) (tuple3$0 reftgen$old$1)) (= (tuple3$1 reftgen$old$1) (mod (+ (tuple3$1 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)))) (= (tuple3$2 reftgen$old$1) (mod (+ (tuple3$2 reftgen$old$1) 1) (tuple3$0 reftgen$old$1)))))) "8"))))))))


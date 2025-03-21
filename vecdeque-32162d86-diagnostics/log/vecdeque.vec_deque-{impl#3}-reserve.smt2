;; Tag 0: Overflow at 394:46: 394:64
;; Tag 1: Fold at 397:17: 397:21
;; Tag 2: Fold at 397:17: 397:21
;; Tag 3: Fold at 397:17: 397:21
;; Tag 4: Fold at 397:17: 397:21
;; Tag 5: Call at 397:17: 397:55
;; Tag 6: Call at 397:17: 397:55

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
(var $k0 (int int int int int)) ;; orig: $k0
(var $k1 (int int int int int int)) ;; orig: $k1
(var $k2 (int int int int int int int int)) ;; orig: $k2
(var $k3 (int int int int int int int int)) ;; orig: $k3
(var $k4 (int int int int int int int int)) ;; orig: $k4
(var $k5 (int int int int int int int int)) ;; orig: $k5

(constraint
 (forall ((reftgen$s$1 (Tuple3 int int int)) (true))
  (forall ((a0 int) (true))
   (forall ((_$ int) ((>= a0 0)))
    (and
     (forall ((a1 int) (true))
      (forall ((a2 int) ((= a2 (tuple3$0 reftgen$s$1))))
       (forall ((a3 int) ((= a3 (tuple3$1 reftgen$s$1))))
        (forall ((a4 int) ((= a4 (tuple3$2 reftgen$s$1))))
         ($k0 a1 a2 a3 a4 a0)))))
     (forall ((a5 int) (true))
      (forall ((_$ int) ((= a5 (tuple3$2 reftgen$s$1))))
       (forall ((_$ int) (and ((c0 a5)) ((<= 1 a5))))
        (forall ((_$ int) ((>= a5 0)))
         (and
          (forall ((a6 int) (true))
           (forall ((a7 int) ((= a7 (tuple3$0 reftgen$s$1))))
            (forall ((a8 int) ((= a8 (tuple3$1 reftgen$s$1))))
             (forall ((a9 int) ((= a9 (tuple3$2 reftgen$s$1))))
              ($k1 a6 a7 a8 a9 a0 a5)))))
          (forall ((a10 int) (true))
           (forall ((_$ int) ((< a10 (tuple3$2 reftgen$s$1))))
            (forall ((_$ int) ((>= a10 0)))
             (forall ((a11 int) (true))
              (forall ((_$ int) (and ((<= (+ (+ a10 1) a0) a11)) ((c0 a11)) ((=> (< a5 a11) (<= (* 2 a5) a11)))))
               (forall ((_$ int) ((>= a11 0)))
                (forall ((_$ int) ((> a11 a5)))
                 (forall ((_$ int) ((< (tuple3$1 reftgen$s$1) (tuple3$2 reftgen$s$1))))
                  (forall ((_$ int) ((>= (tuple3$1 reftgen$s$1) 0)))
                   (forall ((_$ int) ((< (tuple3$0 reftgen$s$1) (tuple3$2 reftgen$s$1))))
                    (forall ((_$ int) ((>= (tuple3$0 reftgen$s$1) 0)))
                     (forall ((_$ int) (and ((c0 (tuple3$2 reftgen$s$1))) ((<= 1 (tuple3$2 reftgen$s$1)))))
                      (and
                       (tag ((>= (- a11 (+ a10 1)) 0)) "0")
                       (forall ((a12 int) (true))
                        (forall ((a13 int) ((= a13 (tuple3$0 reftgen$s$1))))
                         (forall ((a14 int) ((= a14 (tuple3$1 reftgen$s$1))))
                          (forall ((a15 int) ((= a15 (tuple3$2 reftgen$s$1))))
                           ($k2 a12 a13 a14 a15 a0 a5 a10 a11)))))
                       (tag ((< (tuple3$1 reftgen$s$1) (+ (+ a10 1) (- a11 (+ a10 1))))) "1")
                       (tag ((< (tuple3$0 reftgen$s$1) (+ (+ a10 1) (- a11 (+ a10 1))))) "2")
                       (and
                        (tag ((c0 (+ (+ a10 1) (- a11 (+ a10 1))))) "3")
                        (tag ((<= 1 (+ (+ a10 1) (- a11 (+ a10 1))))) "4"))
                       (forall ((a16 int) (true))
                        (forall ((a17 int) ((= a17 (tuple3$0 reftgen$s$1))))
                         (forall ((a18 int) ((= a18 (tuple3$1 reftgen$s$1))))
                          (forall ((a19 int) ((= a19 (tuple3$2 reftgen$s$1))))
                           (forall ((_$ int) ($k2 a16 a17 a18 a19 a0 a5 a10 a11))
                            (forall ((a20 int) ((= a20 (tuple3$0 reftgen$s$1))))
                             (forall ((a21 int) ((= a21 (tuple3$1 reftgen$s$1))))
                              (forall ((a22 int) ((= a22 (tuple3$2 reftgen$s$1))))
                               ($k3 a16 a20 a21 a22 a0 a5 a10 a11)))))))))
                       (forall ((a23 int) (true))
                        (forall ((a24 int) ((= a24 (tuple3$0 reftgen$s$1))))
                         (forall ((a25 int) ((= a25 (tuple3$1 reftgen$s$1))))
                          (forall ((a26 int) ((= a26 (tuple3$2 reftgen$s$1))))
                           ($k4 a23 a24 a25 a26 a0 a5 a10 a11)))))
                       (forall ((a27 int) (true))
                        (forall ((a28 int) ((= a28 (tuple3$0 reftgen$s$1))))
                         (forall ((a29 int) ((= a29 (tuple3$1 reftgen$s$1))))
                          (forall ((a30 int) ((= a30 (tuple3$2 reftgen$s$1))))
                           (forall ((_$ int) ($k3 a27 a28 a29 a30 a0 a5 a10 a11))
                            (forall ((a31 int) ((= a31 (tuple3$0 reftgen$s$1))))
                             (forall ((a32 int) ((= a32 (tuple3$1 reftgen$s$1))))
                              (forall ((a33 int) ((= a33 (tuple3$2 reftgen$s$1))))
                               ($k5 a27 a31 a32 a33 a0 a5 a10 a11)))))))))
                       (and
                        (tag ((<= (* a5 2) (+ (+ a10 1) (- a11 (+ a10 1))))) "5")
                        (tag ((< (tuple3$1 reftgen$s$1) a5)) "6")))))))))))))))))))))))))


;; Tag 0: Assign at 521:9: 521:43
;; Tag 1: Call at 524:13: 524:43

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
(var $k0 (int int int int int)) ;; orig: $k2
(var $k1 (int int int int bool)) ;; orig: $k0
(var $k2 (int int int int int bool)) ;; orig: $k1
(var $k3 (int int int int int int bool)) ;; orig: $k1
(var $k4 (int int int int int int int bool)) ;; orig: $k1
(var $k5 (int int int int int bool)) ;; orig: $k3
(var $k6 (int int int int int bool int int int)) ;; orig: $k4
(var $k7 (int int int int int bool int int int int)) ;; orig: $k5

(constraint
 (forall ((a0 int) (true))
  (forall ((a1 int) (true))
   (forall ((a2 int) (true))
    (forall ((a3 int) (true))
     (and
      (forall ((a4 int) (true))
       ($k0 a4 a0 a1 a2 a3))
      (forall ((a5 bool) (true))
       (and
        (forall ((_$ int) ((not a5)))
         (and
          ($k1 a0 a1 a2 a3 a5)
          (forall ((a6 int) (true))
           (forall ((a7 int) (true))
            (forall ((a8 int) (true))
             (and
              ($k2 a8 a0 a1 a2 a3 a5)
              ($k3 a7 a8 a0 a1 a2 a3 a5)
              ($k4 a6 a7 a8 a0 a1 a2 a3 a5)))))))
        (forall ((_$ int) (a5))
         (and
          (forall ((a9 int) (true))
           (forall ((a10 int) (true))
            (forall ((a11 int) (true))
             (forall ((a12 int) (true))
              ($k5 a12 a0 a1 a2 a3 a5)))))
          ($k1 a0 a1 a2 a3 a5)
          (forall ((a13 int) (true))
           (forall ((a14 int) (true))
            (forall ((a15 int) (true))
             (and
              ($k2 a15 a0 a1 a2 a3 a5)
              ($k3 a14 a15 a0 a1 a2 a3 a5)
              ($k4 a13 a14 a15 a0 a1 a2 a3 a5)))))))
        (forall ((_$ int) ($k1 a0 a1 a2 a3 a5))
         (forall ((a16 int) (true))
          (forall ((a17 int) (true))
           (forall ((a18 int) (true))
            (forall ((_$ int) (and ($k2 a18 a0 a1 a2 a3 a5) ($k3 a17 a18 a0 a1 a2 a3 a5) ($k4 a16 a17 a18 a0 a1 a2 a3 a5)))
             (forall ((_$ int) ((< a17 a18)))
              (forall ((_$ int) ((>= a17 0)))
               (forall ((_$ int) ((< a16 a18)))
                (forall ((_$ int) ((>= a16 0)))
                 (forall ((_$ int) (and ((c0 a18)) ((<= 1 a18))))
                  (and
                   (forall ((a19 int) (true))
                    ($k6 a19 a0 a1 a2 a3 a5 a16 a17 a18))
                   (forall ((a20 int) (true))
                    (forall ((_$ int) ((>= a20 0)))
                     (forall ((_$ int) ((< a17 a18)))
                      (forall ((_$ int) ((>= a17 0)))
                       (forall ((_$ int) ((< a16 a18)))
                        (forall ((_$ int) ((>= a16 0)))
                         (forall ((_$ int) (and ((c0 a18)) ((<= 1 a18))))
                          (and
                           (tag ((= a20 a17)) "0")
                           (forall ((a21 int) (true))
                            ($k7 a21 a0 a1 a2 a3 a5 a16 a17 a18 a20))
                           (forall ((a22 int) (true))
                            (forall ((a23 int) (true))
                             (forall ((a24 int) (true))
                              (and
                               (tag ((= a22 a16)) "1")
                               (tag ((= a23 a17)) "1")
                               (tag ((= a24 a18)) "1")))))
                           ($k7 a0 a0 a1 a2 a3 a5 a16 a17 a18 a20))))))))))))))))))))))))))))


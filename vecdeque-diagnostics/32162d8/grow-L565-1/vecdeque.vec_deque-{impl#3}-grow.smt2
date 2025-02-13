;; Tag 0: FoldLocal at 559:9: 559:49
;; Tag 1: Call at 563:9: 563:39
;; Tag 2: Call at 565:13: 565:51
;; Tag 3: Call at 565:13: 565:51
;; Tag 4: FoldLocal at 565:13: 565:51

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
(var $k0 (int)) ;; orig: $k0
(var $k1 (int)) ;; orig: $k1
(var $k2 (int int)) ;; orig: $k1
(var $k3 (int int int)) ;; orig: $k1
(var $k4 (int int int int)) ;; orig: $k3
(var $k5 (int int int int)) ;; orig: $k4
(var $k6 (int int int int int int int int)) ;; orig: $k5
(var $k7 (int int int int int int int int)) ;; orig: $k6
(var $k8 (int int int int int int int int int)) ;; orig: $k7
(var $k9 (int int int int int int int int int int int)) ;; orig: $k2
(var $k10 (int int int int int int int int int int int int)) ;; orig: $k8

(constraint
 (and
  (forall ((_$ int) (false))
   (and
    (forall ((a0 int) ((= a0 0)))
     ($k0 a0))
    (forall ((a1 int) (true))
     (forall ((a2 int) (true))
      (forall ((a3 int) (true))
       (and
        ($k1 a3)
        ($k2 a2 a3)
        ($k3 a1 a2 a3)))))))
  (forall ((_$ int) (true))
   (forall ((a4 int) (true))
    (forall ((a5 int) (true))
     (forall ((a6 int) (true))
      (and
       (forall ((a7 int) (true))
        ($k4 a7 a4 a5 a6))
       (forall ((a8 bool) (true))
        (forall ((_$ int) (a8))
         (and
          (forall ((a9 int) ((= a9 0)))
           ($k0 a9))
          (forall ((a10 int) (true))
           (forall ((a11 int) (true))
            (forall ((a12 int) (true))
             (and
              ($k1 a12)
              ($k2 a11 a12)
              ($k3 a10 a11 a12)))))))))))))
  (forall ((_$ int) ($k0 a13))
   (forall ((a13 int) ((= a13 0)))
    (forall ((a14 int) (true))
     (forall ((a15 int) (true))
      (forall ((a16 int) (true))
       (forall ((_$ int) (and ($k1 a16) ($k2 a15 a16) ($k3 a14 a15 a16)))
        (and
         (forall ((a17 int) (true))
          ($k5 a17 a14 a15 a16))
         (forall ((a18 int) (true))
          (forall ((_$ int) ((= a18 a16)))
           (forall ((_$ int) (and ((c0 a18)) ((<= 1 a18))))
            (forall ((_$ int) ((>= a18 0)))
             (forall ((a19 int) (true))
              (forall ((a20 int) (true))
               (forall ((a21 int) (true))
                (forall ((_$ int) (and ($k1 a21) ($k2 a20 a21) ($k3 a19 a20 a21)))
                 (forall ((_$ int) ((< a20 a21)))
                  (forall ((_$ int) ((>= a20 0)))
                   (forall ((_$ int) ((< a19 a21)))
                    (forall ((_$ int) ((>= a19 0)))
                     (forall ((_$ int) (and ((c0 a21)) ((<= 1 a21))))
                      (and
                       (forall ((a22 int) (true))
                        ($k6 a22 a14 a15 a16 a18 a19 a20 a21))
                       (tag ((= (+ a18 a18) a21)) "0")
                       (forall ((a23 int) (true))
                        ($k7 a23 a14 a15 a16 a18 a19 a20 a21))
                       (forall ((a24 int) (true))
                        (forall ((_$ int) ((= a24 a21)))
                         (forall ((_$ int) (and ((c0 a24)) ((<= 1 a24))))
                          (forall ((_$ int) ((>= a24 0)))
                           (and
                            (tag ((= (= a24 (* a18 2)) true)) "1")
                            (and
                             (forall ((a25 int) (true))
                              ($k8 a25 a14 a15 a16 a18 a19 a20 a21 a24))
                             (and
                              (tag ((<= (* a18 2) a21)) "2")
                              (tag ((< a20 a18)) "3"))
                             (forall ((a26 int) (true))
                              (forall ((a27 int) (true))
                               (forall ((a28 int) (true))
                                (and
                                 (tag ((= a26 a19)) "4")
                                 (tag ((= a27 a20)) "4")
                                 (tag ((= a28 a21)) "4")
                                 (forall ((_$ int) (false))
                                  ($k9 a14 a15 a16 a18 a19 a20 a21 a24 a26 a27 a28))
                                 (forall ((_$ int) (true))
                                  (and
                                   (forall ((a29 int) (true))
                                    ($k10 a29 a14 a15 a16 a18 a19 a20 a21 a24 a26 a27 a28))
                                   (forall ((a30 bool) (true))
                                    (forall ((_$ int) ((not a30)))
                                     ($k9 a14 a15 a16 a18 a19 a20 a21 a24 a26 a27 a28))))))))))))))))))))))))))))))))))))))


;; Tag 0: Assign at 520:9: 520:43
;; Tag 1: Call at 523:13: 523:43

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
(var $k0 (int int int int int)) ;; orig: $k2
(var $k1 (int int int int bool)) ;; orig: $k0
(var $k2 (int int int int int int int bool)) ;; orig: $k1
(var $k3 (int int int int int int bool)) ;; orig: $k1
(var $k4 (int int int int int bool)) ;; orig: $k1
(var $k5 (int int int int int bool)) ;; orig: $k3
(var $k6 (int int int int int bool int int int)) ;; orig: $k4
(var $k7 (int int int int int bool int int int int)) ;; orig: $k5

(constraint
 (forall ((a0 int) (true))
  (forall ((a1 (Tuple3 int int int)) (true))
   (and
    (forall ((a2 int) (true))
     (forall ((a3 int) ((= a3 (tuple3$0 a1))))
      (forall ((a4 int) ((= a4 (tuple3$1 a1))))
       (forall ((a5 int) ((= a5 (tuple3$2 a1))))
        ($k0 a2 a0 a3 a4 a5)))))
    (forall ((a6 bool) (true))
     (and
      (forall ((_$ int) ((not a6)))
       (and
        (forall ((a7 int) ((= a7 (tuple3$0 a1))))
         (forall ((a8 int) ((= a8 (tuple3$1 a1))))
          (forall ((a9 int) ((= a9 (tuple3$2 a1))))
           ($k1 a0 a7 a8 a9 a6))))
        (forall ((a10 (Tuple3 int int int)) (true))
         (forall ((a11 int) ((= a11 (tuple3$0 a10))))
          (forall ((a12 int) ((= a12 (tuple3$1 a10))))
           (forall ((a13 int) ((= a13 (tuple3$2 a10))))
            (forall ((a14 int) ((= a14 (tuple3$0 a1))))
             (forall ((a15 int) ((= a15 (tuple3$1 a1))))
              (forall ((a16 int) ((= a16 (tuple3$2 a1))))
               (and
                ($k2 a11 a12 a13 a0 a14 a15 a16 a6)
                ($k3 a12 a13 a0 a14 a15 a16 a6)
                ($k4 a13 a0 a14 a15 a16 a6)))))))))))
      (forall ((_$ int) (a6))
       (and
        (forall ((a17 (Tuple3 int int int)) (true))
         (forall ((a18 int) (true))
          (forall ((a19 int) ((= a19 (tuple3$0 a1))))
           (forall ((a20 int) ((= a20 (tuple3$1 a1))))
            (forall ((a21 int) ((= a21 (tuple3$2 a1))))
             ($k5 a18 a0 a19 a20 a21 a6))))))
        (forall ((a22 int) ((= a22 (tuple3$0 a1))))
         (forall ((a23 int) ((= a23 (tuple3$1 a1))))
          (forall ((a24 int) ((= a24 (tuple3$2 a1))))
           ($k1 a0 a22 a23 a24 a6))))
        (forall ((a25 (Tuple3 int int int)) (true))
         (forall ((a26 int) ((= a26 (tuple3$0 a25))))
          (forall ((a27 int) ((= a27 (tuple3$1 a25))))
           (forall ((a28 int) ((= a28 (tuple3$2 a25))))
            (forall ((a29 int) ((= a29 (tuple3$0 a1))))
             (forall ((a30 int) ((= a30 (tuple3$1 a1))))
              (forall ((a31 int) ((= a31 (tuple3$2 a1))))
               (and
                ($k2 a26 a27 a28 a0 a29 a30 a31 a6)
                ($k3 a27 a28 a0 a29 a30 a31 a6)
                ($k4 a28 a0 a29 a30 a31 a6)))))))))))
      (forall ((a32 int) ((= a32 (tuple3$0 a1))))
       (forall ((a33 int) ((= a33 (tuple3$1 a1))))
        (forall ((a34 int) ((= a34 (tuple3$2 a1))))
         (forall ((_$ int) ($k1 a0 a32 a33 a34 a6))
          (forall ((a35 (Tuple3 int int int)) (true))
           (forall ((a36 int) ((= a36 (tuple3$0 a35))))
            (forall ((a37 int) ((= a37 (tuple3$1 a35))))
             (forall ((a38 int) ((= a38 (tuple3$2 a35))))
              (forall ((a39 int) ((= a39 (tuple3$0 a1))))
               (forall ((a40 int) ((= a40 (tuple3$1 a1))))
                (forall ((a41 int) ((= a41 (tuple3$2 a1))))
                 (forall ((_$ int) (and ($k2 a36 a37 a38 a0 a39 a40 a41 a6) ($k3 a37 a38 a0 a39 a40 a41 a6) ($k4 a38 a0 a39 a40 a41 a6)))
                  (forall ((_$ int) ((< (tuple3$1 a35) (tuple3$2 a35))))
                   (forall ((_$ int) ((>= (tuple3$1 a35) 0)))
                    (forall ((_$ int) ((< (tuple3$0 a35) (tuple3$2 a35))))
                     (forall ((_$ int) ((>= (tuple3$0 a35) 0)))
                      (forall ((_$ int) (and ((c0 (tuple3$2 a35))) ((<= 1 (tuple3$2 a35)))))
                       (and
                        (forall ((a42 int) (true))
                         (forall ((a43 int) ((= a43 (tuple3$0 a1))))
                          (forall ((a44 int) ((= a44 (tuple3$1 a1))))
                           (forall ((a45 int) ((= a45 (tuple3$2 a1))))
                            (forall ((a46 int) ((= a46 (tuple3$0 a35))))
                             (forall ((a47 int) ((= a47 (tuple3$1 a35))))
                              (forall ((a48 int) ((= a48 (tuple3$2 a35))))
                               ($k6 a42 a0 a43 a44 a45 a6 a46 a47 a48))))))))
                        (forall ((a49 int) (true))
                         (forall ((_$ int) ((>= a49 0)))
                          (forall ((_$ int) ((< (tuple3$1 a35) (tuple3$2 a35))))
                           (forall ((_$ int) ((>= (tuple3$1 a35) 0)))
                            (forall ((_$ int) ((< (tuple3$0 a35) (tuple3$2 a35))))
                             (forall ((_$ int) ((>= (tuple3$0 a35) 0)))
                              (forall ((_$ int) (and ((c0 (tuple3$2 a35))) ((<= 1 (tuple3$2 a35)))))
                               (and
                                (tag ((= a49 (tuple3$1 a35))) "0")
                                (forall ((a50 int) (true))
                                 (forall ((a51 int) ((= a51 (tuple3$0 a1))))
                                  (forall ((a52 int) ((= a52 (tuple3$1 a1))))
                                   (forall ((a53 int) ((= a53 (tuple3$2 a1))))
                                    (forall ((a54 int) ((= a54 (tuple3$0 a35))))
                                     (forall ((a55 int) ((= a55 (tuple3$1 a35))))
                                      (forall ((a56 int) ((= a56 (tuple3$2 a35))))
                                       ($k7 a50 a0 a51 a52 a53 a6 a54 a55 a56 a49))))))))
                                (forall ((a57 (Tuple3 int int int)) (true))
                                 (tag ((= a57 a35)) "1"))
                                (forall ((a58 int) ((= a58 (tuple3$0 a1))))
                                 (forall ((a59 int) ((= a59 (tuple3$1 a1))))
                                  (forall ((a60 int) ((= a60 (tuple3$2 a1))))
                                   (forall ((a61 int) ((= a61 (tuple3$0 a35))))
                                    (forall ((a62 int) ((= a62 (tuple3$1 a35))))
                                     (forall ((a63 int) ((= a63 (tuple3$2 a35))))
                                      ($k7 a0 a0 a58 a59 a60 a6 a61 a62 a63 a49)))))))))))))))))))))))))))))))))))))))


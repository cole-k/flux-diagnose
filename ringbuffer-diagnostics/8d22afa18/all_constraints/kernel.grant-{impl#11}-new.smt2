;; Tag 0: Call at 1130:47: 1139:10

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
(var $k0 (bool int int int int int int int bool)) ;; orig: $k15
(var $k1 (int bool int int int int int int int bool)) ;; orig: $k17
(var $k2 (int int bool int int int int int int int bool)) ;; orig: $k16
(var $k3 (int int int int int int int bool)) ;; orig: $k18
(var $k4 (int int int int int int int int bool bool int)) ;; orig: $k19
(var $k5 (int int int int int int int int bool bool int)) ;; orig: $k20
(var $k6 (int int int int int int int int bool bool int int)) ;; orig: $k21
(var $k7 (int int int int int int int int bool bool int int int)) ;; orig: $k22
(var $k8 (int int int int int int int int bool bool int int int)) ;; orig: $k23
(var $k9 (bool int int int int int int int bool bool)) ;; orig: $k0
(var $k10 (int bool int int int int int int int bool bool)) ;; orig: $k2
(var $k11 (int int bool int int int int int int int bool bool)) ;; orig: $k1
(var $k12 (int bool int int int int int int int bool bool)) ;; orig: $k4
(var $k13 (int int bool int int int int int int int bool bool)) ;; orig: $k3
(var $k14 (int bool int int int int int int int bool bool)) ;; orig: $k6
(var $k15 (int int bool int int int int int int int bool bool)) ;; orig: $k5
(var $k16 (int bool int int int int int int int bool bool)) ;; orig: $k7
(var $k17 (int bool int int int int int int int bool bool)) ;; orig: $k8
(var $k18 (int bool int int int int int int int bool bool)) ;; orig: $k9
(var $k19 (int bool int int int int int int int bool bool)) ;; orig: $k10
(var $k20 (int bool int int int int int int int bool bool)) ;; orig: $k12
(var $k21 (int int bool int int int int int int int bool bool)) ;; orig: $k11
(var $k22 (int int int int int int int int bool bool)) ;; orig: $k24
(var $k23 (int int int int int int int bool bool bool)) ;; orig: $k36
(var $k24 (int int int int int int int int bool bool bool)) ;; orig: $k32
(var $k25 (int int int int int int int int bool bool bool)) ;; orig: $k33
(var $k26 (int int int int int int int int bool bool bool)) ;; orig: $k34
(var $k27 (int int int int int int int int bool bool bool)) ;; orig: $k35
(var $k28 (int int int int int int int int bool bool bool)) ;; orig: $k37
(var $k29 (int int int int int int int bool bool bool)) ;; orig: $k42
(var $k30 (int int int int int int int int bool bool bool)) ;; orig: $k38
(var $k31 (int int int int int int int int bool bool bool)) ;; orig: $k39
(var $k32 (int int int int int int int int bool bool bool)) ;; orig: $k40
(var $k33 (int int int int int int int int bool bool bool)) ;; orig: $k41
(var $k34 (int int int int int int int bool bool bool)) ;; orig: $k49
(var $k35 (bool int int int int int int int bool bool bool)) ;; orig: $k46
(var $k36 (int bool int int int int int int int bool bool bool)) ;; orig: $k48
(var $k37 (int int bool int int int int int int int bool bool bool)) ;; orig: $k47
(var $k38 (bool int int int int int int int bool bool bool)) ;; orig: $k30

(constraint
 (forall ((a0 int) (true))
  (forall ((_$ int) ((>= a0 0)))
   (forall ((a1 int) (true))
    (forall ((_$ int) ((>= a1 0)))
     (forall ((a2 int) (true))
      (forall ((_$ int) ((>= a2 0)))
       (forall ((a3 int) (true))
        (forall ((_$ int) ((> a3 0)))
         (forall ((_$ int) ((>= a3 0)))
          (forall ((a4 int) (true))
           (forall ((_$ int) ((>= a4 0)))
            (forall ((a5 int) (true))
             (forall ((_$ int) ((>= a5 0)))
              (forall ((a6 int) (true))
               (forall ((_$ int) ((>= a6 0)))
                (and
                 (tag ((and (> a3 0))) "0")
                 (forall ((a7 bool) (true))
                  (and
                   (forall ((a8 bool) (true))
                    (and
                     ($k0 a8 a0 a1 a2 a3 a4 a5 a6 a7)
                     (forall ((a9 int) (true))
                      (and
                       ($k1 a9 a8 a0 a1 a2 a3 a4 a5 a6 a7)
                       (forall ((a10 int) (true))
                        ($k2 a10 a9 a8 a0 a1 a2 a3 a4 a5 a6 a7))))))
                   ($k3 a0 a1 a2 a3 a4 a5 a6 a7)
                   (forall ((a11 bool) (true))
                    (forall ((_$ int) ($k0 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                     (and
                      (forall ((_$ int) ((= a11 true)))
                       (forall ((a12 int) (true))
                        (forall ((_$ int) ($k1 a12 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                         (and
                          (forall ((a13 int) (true))
                           (forall ((_$ int) ($k2 a13 a12 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                            ($k4 a13 a0 a1 a2 a3 a4 a5 a6 a7 a11 a12)))
                          (forall ((a14 int) (true))
                           (and
                            (forall ((a15 int) (true))
                             (forall ((_$ int) ($k5 a15 a0 a1 a2 a3 a4 a5 a6 a7 a11 a12))
                              ($k6 a15 a0 a1 a2 a3 a4 a5 a6 a7 a11 a12 a14)))
                            (forall ((a16 int) (true))
                             (and
                              ($k7 a16 a0 a1 a2 a3 a4 a5 a6 a7 a11 a12 a14 a16)
                              ($k8 a12 a0 a1 a2 a3 a4 a5 a6 a7 a11 a12 a14 a16)
                              (forall ((a17 bool) ((= a17 true)))
                               ($k9 a17 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                              (forall ((a18 int) (true))
                               (forall ((_$ int) ($k8 a18 a0 a1 a2 a3 a4 a5 a6 a7 a11 a12 a14 a16))
                                (and
                                 (forall ((a19 bool) ((= a19 true)))
                                  ($k10 a18 a19 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                                 (forall ((a20 int) (true))
                                  (forall ((_$ int) ($k2 a20 a18 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                                   (forall ((a21 bool) ((= a21 true)))
                                    ($k11 a20 a18 a21 a0 a1 a2 a3 a4 a5 a6 a7 a11)))))))
                              (forall ((a22 int) (true))
                               (forall ((_$ int) ($k1 a22 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                                (and
                                 (forall ((a23 bool) ((= a23 true)))
                                  ($k12 a22 a23 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                                 (forall ((a24 int) (true))
                                  (forall ((_$ int) ($k2 a24 a22 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                                   (forall ((a25 bool) ((= a25 true)))
                                    ($k13 a24 a22 a25 a0 a1 a2 a3 a4 a5 a6 a7 a11)))))))
                              (forall ((a26 int) (true))
                               (forall ((_$ int) ($k1 a26 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                                (and
                                 (forall ((a27 bool) ((= a27 true)))
                                  ($k14 a26 a27 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                                 (forall ((a28 int) (true))
                                  (forall ((_$ int) ($k2 a28 a26 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                                   (forall ((a29 bool) ((= a29 true)))
                                    ($k15 a28 a26 a29 a0 a1 a2 a3 a4 a5 a6 a7 a11)))))))
                              (forall ((a30 int) (true))
                               (forall ((a31 int) (true))
                                (forall ((a32 int) (true))
                                 (forall ((a33 int) (true))
                                  (and
                                   (forall ((a34 bool) ((= a34 true)))
                                    ($k16 a30 a34 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                                   (forall ((a35 bool) ((= a35 true)))
                                    ($k17 a31 a35 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                                   (forall ((a36 bool) ((= a36 true)))
                                    ($k18 a32 a36 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                                   (forall ((a37 bool) ((= a37 true)))
                                    ($k19 a33 a37 a0 a1 a2 a3 a4 a5 a6 a7 a11)))))))
                              (forall ((a38 int) (true))
                               (forall ((_$ int) ($k1 a38 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                                (and
                                 (forall ((a39 bool) ((= a39 true)))
                                  ($k20 a38 a39 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                                 (forall ((a40 int) (true))
                                  (forall ((_$ int) ($k2 a40 a38 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                                   (forall ((a41 bool) ((= a41 true)))
                                    ($k21 a40 a38 a41 a0 a1 a2 a3 a4 a5 a6 a7 a11)))))))))))))))
                      (forall ((_$ int) ((= a11 false)))
                       (and
                        (forall ((a42 bool) ((= a42 false)))
                         ($k9 a42 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                        (forall ((a43 int) (true))
                         (forall ((_$ int) ($k22 a43 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                          (and
                           (forall ((a44 bool) ((= a44 false)))
                            ($k10 a43 a44 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                           (forall ((a45 int) (true))
                            (forall ((_$ int) ($k2 a45 a43 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                             (forall ((a46 bool) ((= a46 false)))
                              ($k11 a45 a43 a46 a0 a1 a2 a3 a4 a5 a6 a7 a11)))))))
                        (forall ((a47 int) (true))
                         (forall ((_$ int) ($k1 a47 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                          (and
                           (forall ((a48 bool) ((= a48 false)))
                            ($k12 a47 a48 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                           (forall ((a49 int) (true))
                            (forall ((_$ int) ($k2 a49 a47 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                             (forall ((a50 bool) ((= a50 false)))
                              ($k13 a49 a47 a50 a0 a1 a2 a3 a4 a5 a6 a7 a11)))))))
                        (forall ((a51 int) (true))
                         (forall ((_$ int) ($k1 a51 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                          (and
                           (forall ((a52 bool) ((= a52 false)))
                            ($k14 a51 a52 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                           (forall ((a53 int) (true))
                            (forall ((_$ int) ($k2 a53 a51 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                             (forall ((a54 bool) ((= a54 false)))
                              ($k15 a53 a51 a54 a0 a1 a2 a3 a4 a5 a6 a7 a11)))))))
                        (forall ((a55 int) (true))
                         (forall ((a56 int) (true))
                          (forall ((a57 int) (true))
                           (forall ((a58 int) (true))
                            (and
                             (forall ((a59 bool) ((= a59 false)))
                              ($k16 a55 a59 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                             (forall ((a60 bool) ((= a60 false)))
                              ($k17 a56 a60 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                             (forall ((a61 bool) ((= a61 false)))
                              ($k18 a57 a61 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                             (forall ((a62 bool) ((= a62 false)))
                              ($k19 a58 a62 a0 a1 a2 a3 a4 a5 a6 a7 a11)))))))
                        (forall ((a63 int) (true))
                         (forall ((_$ int) ($k1 a63 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                          (and
                           (forall ((a64 bool) ((= a64 false)))
                            ($k20 a63 a64 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                           (forall ((a65 int) (true))
                            (forall ((_$ int) ($k2 a65 a63 a11 a0 a1 a2 a3 a4 a5 a6 a7))
                             (forall ((a66 bool) ((= a66 false)))
                              ($k21 a65 a63 a66 a0 a1 a2 a3 a4 a5 a6 a7 a11)))))))))
                      (forall ((a67 bool) (true))
                       (forall ((_$ int) ($k9 a67 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                        (and
                         (forall ((_$ int) ($k23 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67))
                          (forall ((a68 int) (true))
                           (forall ((_$ int) ($k24 a68 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67))
                            (forall ((a69 int) (true))
                             (forall ((_$ int) ($k25 a69 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67))
                              (forall ((a70 int) (true))
                               (forall ((_$ int) ($k26 a70 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67))
                                (forall ((a71 int) (true))
                                 (forall ((_$ int) ($k27 a71 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67))
                                  ($k28 a68 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67))))))))))
                         ($k29 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67)
                         (forall ((a72 int) (true))
                          (forall ((_$ int) ($k28 a72 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67))
                           ($k30 a72 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67)))
                         (forall ((a73 int) (true))
                          ($k31 a73 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67))
                         (forall ((a74 int) (true))
                          ($k32 a74 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67))
                         (forall ((a75 int) (true))
                          ($k33 a75 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67))
                         ($k34 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67)
                         ($k35 a11 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67)
                         (forall ((a76 int) (true))
                          (forall ((_$ int) ($k14 a76 a67 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                           (and
                            ($k36 a76 a11 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67)
                            (forall ((a77 int) (true))
                             (forall ((_$ int) ($k15 a77 a76 a67 a0 a1 a2 a3 a4 a5 a6 a7 a11))
                              ($k37 a77 a76 a11 a0 a1 a2 a3 a4 a5 a6 a7 a11 a67))))))))))))
                   (forall ((a78 bool) (true))
                    (forall ((a79 bool) (true))
                     ($k38 a78 a0 a1 a2 a3 a4 a5 a6 a7 a78 a79))))))))))))))))))))))


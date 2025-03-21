;; Tag 0: FoldLocal at 559:9: 559:49
;; Tag 1: Call at 563:9: 563:39
;; Tag 2: Call at 565:13: 565:51
;; Tag 3: Call at 565:13: 565:51
;; Tag 4: FoldLocal at 565:13: 565:51

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
(var $k0 (int)) ;; orig: $k0
(var $k1 (int int int)) ;; orig: $k1
(var $k2 (int int)) ;; orig: $k1
(var $k3 (int)) ;; orig: $k1
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
    (forall ((a1 (Tuple3 int int int)) (true))
     (forall ((a2 int) ((= a2 (tuple3$0 a1))))
      (forall ((a3 int) ((= a3 (tuple3$1 a1))))
       (forall ((a4 int) ((= a4 (tuple3$2 a1))))
        (and
         ($k1 a2 a3 a4)
         ($k2 a3 a4)
         ($k3 a4))))))))
  (forall ((_$ int) (true))
   (forall ((a5 (Tuple3 int int int)) (true))
    (and
     (forall ((a6 int) (true))
      (forall ((a7 int) ((= a7 (tuple3$0 a5))))
       (forall ((a8 int) ((= a8 (tuple3$1 a5))))
        (forall ((a9 int) ((= a9 (tuple3$2 a5))))
         ($k4 a6 a7 a8 a9)))))
     (forall ((a10 bool) (true))
      (forall ((_$ int) (a10))
       (and
        (forall ((a11 int) ((= a11 0)))
         ($k0 a11))
        (forall ((a12 (Tuple3 int int int)) (true))
         (forall ((a13 int) ((= a13 (tuple3$0 a12))))
          (forall ((a14 int) ((= a14 (tuple3$1 a12))))
           (forall ((a15 int) ((= a15 (tuple3$2 a12))))
            (and
             ($k1 a13 a14 a15)
             ($k2 a14 a15)
             ($k3 a15))))))))))))
  (forall ((a16 int) ((= a16 0)))
   (forall ((_$ int) ($k0 a16))
    (forall ((a17 (Tuple3 int int int)) (true))
     (forall ((a18 int) ((= a18 (tuple3$0 a17))))
      (forall ((a19 int) ((= a19 (tuple3$1 a17))))
       (forall ((a20 int) ((= a20 (tuple3$2 a17))))
        (forall ((_$ int) (and ($k1 a18 a19 a20) ($k2 a19 a20) ($k3 a20)))
         (and
          (forall ((a21 int) (true))
           (forall ((a22 int) ((= a22 (tuple3$0 a17))))
            (forall ((a23 int) ((= a23 (tuple3$1 a17))))
             (forall ((a24 int) ((= a24 (tuple3$2 a17))))
              ($k5 a21 a22 a23 a24)))))
          (forall ((a25 int) (true))
           (forall ((_$ int) ((= a25 (tuple3$2 a17))))
            (forall ((_$ int) (and ((c0 a25)) ((<= 1 a25))))
             (forall ((_$ int) ((>= a25 0)))
              (forall ((a26 (Tuple3 int int int)) (true))
               (forall ((a27 int) ((= a27 (tuple3$0 a26))))
                (forall ((a28 int) ((= a28 (tuple3$1 a26))))
                 (forall ((a29 int) ((= a29 (tuple3$2 a26))))
                  (forall ((_$ int) (and ($k1 a27 a28 a29) ($k2 a28 a29) ($k3 a29)))
                   (forall ((_$ int) ((< (tuple3$1 a26) (tuple3$2 a26))))
                    (forall ((_$ int) ((>= (tuple3$1 a26) 0)))
                     (forall ((_$ int) ((< (tuple3$0 a26) (tuple3$2 a26))))
                      (forall ((_$ int) ((>= (tuple3$0 a26) 0)))
                       (forall ((_$ int) (and ((c0 (tuple3$2 a26))) ((<= 1 (tuple3$2 a26)))))
                        (and
                         (forall ((a30 int) (true))
                          (forall ((a31 int) ((= a31 (tuple3$0 a17))))
                           (forall ((a32 int) ((= a32 (tuple3$1 a17))))
                            (forall ((a33 int) ((= a33 (tuple3$2 a17))))
                             (forall ((a34 int) ((= a34 (tuple3$0 a26))))
                              (forall ((a35 int) ((= a35 (tuple3$1 a26))))
                               (forall ((a36 int) ((= a36 (tuple3$2 a26))))
                                ($k6 a30 a31 a32 a33 a25 a34 a35 a36))))))))
                         (tag ((= (+ a25 a25) (tuple3$2 a26))) "0")
                         (forall ((a37 int) (true))
                          (forall ((a38 int) ((= a38 (tuple3$0 a17))))
                           (forall ((a39 int) ((= a39 (tuple3$1 a17))))
                            (forall ((a40 int) ((= a40 (tuple3$2 a17))))
                             (forall ((a41 int) ((= a41 (tuple3$0 a26))))
                              (forall ((a42 int) ((= a42 (tuple3$1 a26))))
                               (forall ((a43 int) ((= a43 (tuple3$2 a26))))
                                ($k7 a37 a38 a39 a40 a25 a41 a42 a43))))))))
                         (forall ((a44 int) (true))
                          (forall ((_$ int) ((= a44 (tuple3$2 a26))))
                           (forall ((_$ int) (and ((c0 a44)) ((<= 1 a44))))
                            (forall ((_$ int) ((>= a44 0)))
                             (and
                              (tag ((= (= a44 (* a25 2)) true)) "1")
                              (and
                               (forall ((a45 int) (true))
                                (forall ((a46 int) ((= a46 (tuple3$0 a17))))
                                 (forall ((a47 int) ((= a47 (tuple3$1 a17))))
                                  (forall ((a48 int) ((= a48 (tuple3$2 a17))))
                                   (forall ((a49 int) ((= a49 (tuple3$0 a26))))
                                    (forall ((a50 int) ((= a50 (tuple3$1 a26))))
                                     (forall ((a51 int) ((= a51 (tuple3$2 a26))))
                                      ($k8 a45 a46 a47 a48 a25 a49 a50 a51 a44))))))))
                               (and
                                (tag ((<= (* a25 2) (tuple3$2 a26))) "2")
                                (tag ((< (tuple3$1 a26) a25)) "3"))
                               (forall ((a52 (Tuple3 int int int)) (true))
                                (and
                                 (tag ((= a52 a26)) "4")
                                 (forall ((_$ int) (false))
                                  (forall ((a53 int) ((= a53 (tuple3$0 a17))))
                                   (forall ((a54 int) ((= a54 (tuple3$1 a17))))
                                    (forall ((a55 int) ((= a55 (tuple3$2 a17))))
                                     (forall ((a56 int) ((= a56 (tuple3$0 a26))))
                                      (forall ((a57 int) ((= a57 (tuple3$1 a26))))
                                       (forall ((a58 int) ((= a58 (tuple3$2 a26))))
                                        (forall ((a59 int) ((= a59 (tuple3$0 a52))))
                                         (forall ((a60 int) ((= a60 (tuple3$1 a52))))
                                          (forall ((a61 int) ((= a61 (tuple3$2 a52))))
                                           ($k9 a53 a54 a55 a25 a56 a57 a58 a44 a59 a60 a61)))))))))))
                                 (forall ((_$ int) (true))
                                  (and
                                   (forall ((a62 int) (true))
                                    (forall ((a63 int) ((= a63 (tuple3$0 a17))))
                                     (forall ((a64 int) ((= a64 (tuple3$1 a17))))
                                      (forall ((a65 int) ((= a65 (tuple3$2 a17))))
                                       (forall ((a66 int) ((= a66 (tuple3$0 a26))))
                                        (forall ((a67 int) ((= a67 (tuple3$1 a26))))
                                         (forall ((a68 int) ((= a68 (tuple3$2 a26))))
                                          (forall ((a69 int) ((= a69 (tuple3$0 a52))))
                                           (forall ((a70 int) ((= a70 (tuple3$1 a52))))
                                            (forall ((a71 int) ((= a71 (tuple3$2 a52))))
                                             ($k10 a62 a63 a64 a65 a25 a66 a67 a68 a44 a69 a70 a71)))))))))))
                                   (forall ((a72 bool) (true))
                                    (forall ((_$ int) ((not a72)))
                                     (forall ((a73 int) ((= a73 (tuple3$0 a17))))
                                      (forall ((a74 int) ((= a74 (tuple3$1 a17))))
                                       (forall ((a75 int) ((= a75 (tuple3$2 a17))))
                                        (forall ((a76 int) ((= a76 (tuple3$0 a26))))
                                         (forall ((a77 int) ((= a77 (tuple3$1 a26))))
                                          (forall ((a78 int) ((= a78 (tuple3$2 a26))))
                                           (forall ((a79 int) ((= a79 (tuple3$0 a52))))
                                            (forall ((a80 int) ((= a80 (tuple3$1 a52))))
                                             (forall ((a81 int) ((= a81 (tuple3$2 a52))))
                                              ($k9 a73 a74 a75 a25 a76 a77 a78 a44 a79 a80 a81)))))))))))))))))))))))))))))))))))))))))))))))


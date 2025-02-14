;; Tag 0: Call at 105:5: 105:53
;; Tag 1: Ret at 108:1: 108:2
;; Tag 2: Call at 99:28: 99:31
;; Tag 3: Call at 99:17: 99:37
;; Tag 4: Call at 99:17: 99:37
;; Tag 5: Call at 100:28: 100:31
;; Tag 6: Call at 100:36: 100:39
;; Tag 7: Call at 100:9: 100:40
;; Tag 8: Call at 101:17: 101:20

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
(var $k0 (int int int int)) ;; orig: $k3
(var $k1 (int int int int)) ;; orig: $k4
(var $k2 (int int int int)) ;; orig: $k0
(var $k3 (int int int int int)) ;; orig: $k1
(var $k4 (int int int int int)) ;; orig: $k2
(var $k5 (int int int int int)) ;; orig: $k5
(var $k6 (int int int int int)) ;; orig: $k6
(var $k7 (int int int int int int int)) ;; orig: $k7
(var $k8 (int int int int int int int)) ;; orig: $k8
(var $k9 (int int int int int int int int int)) ;; orig: $k9

(constraint
 (forall ((reftgen$n$0 int) (true))
  (forall ((reftgen$k$1 int) (true))
   (forall ((_$ int) ((>= reftgen$n$0 0)))
    (forall ((_$ int) ((<= 0 reftgen$k$1)))
     (forall ((a0 int) (true))
      (forall ((_$ int) ((<= 0 a0)))
       (and
        (forall ((a1 int) (true))
         (forall ((_$ int) ((= a1 reftgen$n$0)))
          (forall ((a2 int) ((= a2 reftgen$k$1)))
           ($k0 a1 reftgen$n$0 a2 a0))))
        (forall ((_$ int) ((>= reftgen$k$1 0)))
         (forall ((_$ int) ((<= 0 reftgen$k$1)))
          (and
           (forall ((a3 int) ((= a3 0)))
            (forall ((a4 int) ((= a4 reftgen$k$1)))
             ($k1 a3 reftgen$n$0 a4 a0)))
           (forall ((_$ int) ((<= 0 reftgen$k$1)))
            (and
             (forall ((a5 int) ((= a5 0)))
              (forall ((a6 int) ((= a6 reftgen$k$1)))
               ($k2 a5 reftgen$n$0 a6 a0)))
             (forall ((a7 int) (true))
              (forall ((_$ int) ((= a7 reftgen$n$0)))
               (forall ((a8 int) ((= a8 0)))
                (forall ((a9 int) ((= a9 reftgen$k$1)))
                 ($k3 a7 a8 reftgen$n$0 a9 a0)))))
             (forall ((a10 int) (true))
              (forall ((_$ int) ($k1 a10 reftgen$n$0 a11 a0))
               (forall ((a11 int) ((= a11 reftgen$k$1)))
                (forall ((a12 int) ((= a12 0)))
                 (forall ((a13 int) ((= a13 reftgen$k$1)))
                  ($k4 a10 a12 reftgen$n$0 a13 a0))))))
             (forall ((a14 int) (true))
              (forall ((_$ int) ($k2 a14 reftgen$n$0 a15 a0))
               (forall ((a15 int) ((= a15 reftgen$k$1)))
                (and
                 (forall ((a16 int) (true))
                  (forall ((_$ int) ((= a16 reftgen$n$0)))
                   (forall ((a17 int) ((= a17 reftgen$k$1)))
                    ($k5 a16 reftgen$n$0 a17 a0 a14))))
                 (forall ((_$ int) ((>= a0 0)))
                  (and
                   (forall ((_$ int) ((not (< a14 a0))))
                    (and
                     (forall ((a18 int) (true))
                      (forall ((_$ int) ($k3 a18 a14 reftgen$n$0 a19 a0))
                       (forall ((a19 int) ((= a19 reftgen$k$1)))
                        (tag ((= a18 reftgen$n$0)) "0"))))
                     (forall ((a20 int) (true))
                      (forall ((_$ int) ((= a20 reftgen$n$0)))
                       (tag ((= a20 reftgen$n$0)) "1")))
                     (tag ((= reftgen$k$1 reftgen$k$1)) "1")))
                   (forall ((_$ int) ((< a14 a0)))
                    (and
                     (forall ((a21 int) (true))
                      (forall ((_$ int) ((= a21 reftgen$n$0)))
                       (forall ((a22 int) ((= a22 reftgen$k$1)))
                        ($k6 a21 reftgen$n$0 a22 a0 a14))))
                     (tag ((< a14 a0)) "2")
                     (forall ((a23 int) (true))
                      (forall ((_$ int) ($k6 a23 reftgen$n$0 a24 a0 a14))
                       (forall ((a24 int) ((= a24 reftgen$k$1)))
                        (forall ((_$ int) ((<= 0 a23)))
                         (and
                          (tag ((and (> reftgen$k$1 0))) "3")
                          (forall ((a25 int) (true))
                           (forall ((_$ int) ((= a25 reftgen$n$0)))
                            (tag ((= a25 a23)) "4")))
                          (forall ((a26 int) (true))
                           (forall ((_$ int) ((< a26 reftgen$k$1)))
                            (forall ((_$ int) ((>= a26 0)))
                             (and
                              (forall ((a27 int) (true))
                               (forall ((_$ int) ($k3 a27 a14 reftgen$n$0 a28 a0))
                                (forall ((a28 int) ((= a28 reftgen$k$1)))
                                 (forall ((a29 int) ((= a29 reftgen$k$1)))
                                  ($k7 a27 reftgen$n$0 a29 a0 a14 a23 a26)))))
                              (tag ((< a26 reftgen$k$1)) "5")
                              (forall ((a30 int) (true))
                               (forall ((_$ int) ((= a30 reftgen$n$0)))
                                (forall ((a31 int) ((= a31 reftgen$k$1)))
                                 ($k8 a30 reftgen$n$0 a31 a0 a14 a23 a26))))
                              (tag ((< a14 a0)) "6")
                              (forall ((a32 int) (true))
                               (forall ((_$ int) ($k8 a32 reftgen$n$0 a33 a0 a14 a23 a26))
                                (forall ((a33 int) ((= a33 reftgen$k$1)))
                                 (forall ((_$ int) ((<= 0 a32)))
                                  (forall ((a34 int) (true))
                                   (forall ((_$ int) ($k7 a34 reftgen$n$0 a35 a0 a14 a23 a26))
                                    (forall ((a35 int) ((= a35 reftgen$k$1)))
                                     (and
                                      (tag ((= a32 a34)) "7")
                                      (forall ((a36 int) (true))
                                       (forall ((_$ int) ($k4 a36 a14 reftgen$n$0 a37 a0))
                                        (forall ((a37 int) ((= a37 reftgen$k$1)))
                                         (forall ((a38 int) ((= a38 reftgen$k$1)))
                                          ($k9 a36 reftgen$n$0 a38 a0 a14 a23 a26 a32 a34)))))
                                      (tag ((< a26 reftgen$k$1)) "8")
                                      (forall ((a39 int) (true))
                                       (forall ((_$ int) ((>= a39 0)))
                                        (forall ((_$ int) ($k9 a39 reftgen$n$0 a40 a0 a14 a23 a26 a32 a34))
                                         (forall ((a40 int) ((= a40 reftgen$k$1)))
                                          (and
                                           (forall ((a41 int) ((= a41 (+ a39 1))))
                                            (forall ((a42 int) ((= a42 reftgen$k$1)))
                                             ($k9 a41 reftgen$n$0 a42 a0 a14 a23 a26 a32 a34)))
                                           (forall ((a43 int) ((= a43 (+ a14 1))))
                                            (forall ((a44 int) ((= a44 reftgen$k$1)))
                                             ($k2 a43 reftgen$n$0 a44 a0)))
                                           (forall ((a45 int) (true))
                                            (forall ((_$ int) ($k7 a45 reftgen$n$0 a46 a0 a14 a23 a26))
                                             (forall ((a46 int) ((= a46 reftgen$k$1)))
                                              (forall ((a47 int) ((= a47 (+ a14 1))))
                                               (forall ((a48 int) ((= a48 reftgen$k$1)))
                                                ($k3 a45 a47 reftgen$n$0 a48 a0))))))
                                           (forall ((a49 int) (true))
                                            (forall ((_$ int) ($k9 a49 reftgen$n$0 a50 a0 a14 a23 a26 a32 a34))
                                             (forall ((a50 int) ((= a50 reftgen$k$1)))
                                              (forall ((a51 int) ((= a51 (+ a14 1))))
                                               (forall ((a52 int) ((= a52 reftgen$k$1)))
                                                ($k4 a49 a51 reftgen$n$0 a52 a0)))))))))))))))))))))))))))))))))))))))))))))))))


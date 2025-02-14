;; Tag 0: Call at 102:28: 102:31
;; Tag 1: Call at 103:28: 103:31
;; Tag 2: Call at 103:36: 103:39
;; Tag 3: Call at 104:17: 104:20

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
(var $k1 (int int int int int)) ;; orig: $k4
(var $k2 (int int int int int)) ;; orig: $k0
(var $k3 (int int int int int int)) ;; orig: $k1
(var $k4 (int int int int int int)) ;; orig: $k2
(var $k5 (int int int int int int)) ;; orig: $k5
(var $k6 (int int int int int int)) ;; orig: $k6
(var $k7 (int int int int int int int int)) ;; orig: $k7
(var $k8 (int int int int int int int int)) ;; orig: $k8
(var $k9 (int int int int int int int int int int)) ;; orig: $k9

(constraint
 (forall ((a0 int) (true))
  (forall ((_$ int) ((>= a0 0)))
   (forall ((a1 int) (true))
    (forall ((_$ int) ((<= 0 a1)))
     (forall ((a2 int) (true))
      (forall ((_$ int) ((<= 0 a2)))
       (and
        (forall ((a3 int) (true))
         ($k0 a3 a0 a1 a2))
        (forall ((_$ int) ((>= a1 0)))
         (forall ((a4 int) (true))
          (forall ((_$ int) ((<= 0 a4)))
           (and
            (forall ((a5 int) ((= a5 0)))
             ($k1 a5 a0 a1 a2 a4))
            (forall ((_$ int) ((<= 0 a1)))
             (and
              (forall ((a6 int) ((= a6 0)))
               ($k2 a6 a0 a1 a2 a4))
              (forall ((a7 int) (true))
               (forall ((a8 int) ((= a8 0)))
                ($k3 a7 a8 a0 a1 a2 a4)))
              (forall ((a9 int) (true))
               (forall ((_$ int) ($k1 a9 a0 a1 a2 a4))
                (forall ((a10 int) ((= a10 0)))
                 ($k4 a9 a10 a0 a1 a2 a4))))
              (forall ((a11 int) (true))
               (forall ((_$ int) ($k2 a11 a0 a1 a2 a4))
                (and
                 (forall ((a12 int) (true))
                  ($k5 a12 a0 a1 a2 a4 a11))
                 (forall ((_$ int) ((>= a2 0)))
                  (forall ((_$ int) ((< a11 a2)))
                   (and
                    (forall ((a13 int) (true))
                     ($k6 a13 a0 a1 a2 a4 a11))
                    (tag ((< a11 a2)) "0")
                    (forall ((a14 int) (true))
                     (forall ((_$ int) ($k6 a14 a0 a1 a2 a4 a11))
                      (forall ((_$ int) ((<= 0 a14)))
                       (forall ((a15 int) (true))
                        (forall ((_$ int) ((>= a15 0)))
                         (and
                          (forall ((a16 int) (true))
                           (forall ((_$ int) ($k3 a16 a11 a0 a1 a2 a4))
                            ($k7 a16 a0 a1 a2 a4 a11 a14 a15)))
                          (tag ((< a15 a4)) "1")
                          (forall ((a17 int) (true))
                           ($k8 a17 a0 a1 a2 a4 a11 a14 a15))
                          (tag ((< a11 a2)) "2")
                          (forall ((a18 int) (true))
                           (forall ((_$ int) ($k8 a18 a0 a1 a2 a4 a11 a14 a15))
                            (forall ((_$ int) ((<= 0 a18)))
                             (and
                              (forall ((a19 int) (true))
                               ($k7 a19 a0 a1 a2 a4 a11 a14 a15))
                              (forall ((a20 int) (true))
                               (and
                                (forall ((a21 int) (true))
                                 (forall ((_$ int) ($k4 a21 a11 a0 a1 a2 a4))
                                  ($k9 a21 a0 a1 a2 a4 a11 a14 a15 a18 a20)))
                                (tag ((< a15 a1)) "3")
                                (forall ((a22 int) (true))
                                 (forall ((_$ int) ((>= a22 0)))
                                  (forall ((_$ int) ($k9 a22 a0 a1 a2 a4 a11 a14 a15 a18 a20))
                                   (and
                                    (forall ((a23 int) ((= a23 (+ a22 1))))
                                     ($k9 a23 a0 a1 a2 a4 a11 a14 a15 a18 a20))
                                    (forall ((a24 int) ((= a24 (+ a11 1))))
                                     ($k2 a24 a0 a1 a2 a4))
                                    (forall ((a25 int) (true))
                                     (forall ((_$ int) ($k7 a25 a0 a1 a2 a4 a11 a14 a15))
                                      (forall ((a26 int) ((= a26 (+ a11 1))))
                                       ($k3 a25 a26 a0 a1 a2 a4))))
                                    (forall ((a27 int) (true))
                                     (forall ((_$ int) ($k9 a27 a0 a1 a2 a4 a11 a14 a15 a18 a20))
                                      (forall ((a28 int) ((= a28 (+ a11 1))))
                                       ($k4 a27 a28 a0 a1 a2 a4))))))))))))))))))))))))))))))))))))))))


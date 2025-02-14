;; Tag 0: Ret at 75:5: 75:8
;; Tag 1: Call at 68:26: 68:29
;; Tag 2: Call at 68:18: 68:33

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
(var $k0 (int int int)) ;; orig: $k2
(var $k1 (int int int)) ;; orig: $k1
(var $k2 (int int int int)) ;; orig: $k1
(var $k3 (int int int int int)) ;; orig: $k3
(var $k4 (int int int int int int bool)) ;; orig: $k0

(constraint
 (forall ((reftgen$n$0 int) (true))
  (forall ((reftgen$k$1 int) (true))
   (forall ((_$ int) ((<= 0 reftgen$n$0)))
    (forall ((_$ int) ((<= 0 reftgen$k$1)))
     (and
      (forall ((a0 int) (true))
       (forall ((_$ int) ((= a0 reftgen$n$0)))
        (forall ((a1 int) ((= a1 reftgen$n$0)))
         (forall ((a2 int) ((= a2 reftgen$k$1)))
          ($k0 a0 a1 a2)))))
      (forall ((_$ int) ((>= reftgen$k$1 0)))
       (and
        (forall ((a3 int) ((= a3 0)))
         (forall ((a4 int) ((= a4 0)))
          (forall ((a5 int) ((= a5 reftgen$n$0)))
           (forall ((a6 int) ((= a6 reftgen$k$1)))
            (and
             ($k1 a4 a5 a6)
             ($k2 a3 a4 a5 a6))))))
        (forall ((a7 int) (true))
         (forall ((a8 int) (true))
          (forall ((_$ int) (and ($k1 a8 a9 a10) ($k2 a7 a8 a9 a10)))
           (forall ((a9 int) ((= a9 reftgen$n$0)))
            (forall ((a10 int) ((= a10 reftgen$k$1)))
             (and
              (forall ((_$ int) ((not (< a7 reftgen$k$1))))
               (tag ((< a8 reftgen$k$1)) "0"))
              (forall ((_$ int) ((< a7 reftgen$k$1)))
               (and
                (forall ((a11 int) (true))
                 (forall ((_$ int) ((= a11 reftgen$n$0)))
                  (forall ((a12 int) ((= a12 reftgen$n$0)))
                   (forall ((a13 int) ((= a13 reftgen$k$1)))
                    ($k3 a11 a12 a13 a7 a8)))))
                (tag ((< a7 reftgen$k$1)) "1")
                (forall ((a14 int) (true))
                 (forall ((_$ int) ($k3 a14 a15 a16 a7 a8))
                  (forall ((a15 int) ((= a15 reftgen$n$0)))
                   (forall ((a16 int) ((= a16 reftgen$k$1)))
                    (forall ((_$ int) ((<= 0 a14)))
                     (and
                      (tag ((= reftgen$n$0 a14)) "2")
                      (forall ((a17 bool) (true))
                       (and
                        (forall ((_$ int) ((not a17)))
                         (forall ((a18 int) ((= a18 reftgen$n$0)))
                          (forall ((a19 int) ((= a19 reftgen$k$1)))
                           ($k4 a8 a18 a19 a7 a8 a14 a17))))
                        (forall ((_$ int) (a17))
                         (forall ((a20 int) ((= a20 reftgen$n$0)))
                          (forall ((a21 int) ((= a21 reftgen$k$1)))
                           ($k4 a7 a20 a21 a7 a8 a14 a17))))
                        (forall ((a22 int) (true))
                         (forall ((_$ int) ($k4 a22 a23 a24 a7 a8 a14 a17))
                          (forall ((a23 int) ((= a23 reftgen$n$0)))
                           (forall ((a24 int) ((= a24 reftgen$k$1)))
                            (forall ((a25 int) ((= a25 (+ a7 1))))
                             (forall ((a26 int) ((= a26 reftgen$n$0)))
                              (forall ((a27 int) ((= a27 reftgen$k$1)))
                               (and
                                ($k1 a22 a26 a27)
                                ($k2 a25 a22 a26 a27)))))))))))))))))))))))))))))))))


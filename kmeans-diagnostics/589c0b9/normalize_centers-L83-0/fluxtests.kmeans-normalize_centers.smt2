;; Tag 0: Call at 83:23: 83:26
;; Tag 1: Call at 83:35: 83:38

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
(var $k0 (int int int int)) ;; orig: $k2
(var $k1 (int int int int)) ;; orig: $k0
(var $k2 (int int int int int)) ;; orig: $k1
(var $k3 (int int int int int int)) ;; orig: $k3
(var $k4 (int int int int int int)) ;; orig: $k4

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
        (forall ((_$ int) ((>= a2 0)))
         (and
          (forall ((a4 int) ((= a4 0)))
           ($k1 a4 a0 a1 a2))
          (forall ((a5 int) (true))
           (forall ((a6 int) ((= a6 0)))
            ($k2 a5 a6 a0 a1 a2)))
          (forall ((a7 int) (true))
           (forall ((_$ int) ($k1 a7 a0 a1 a2))
            (forall ((_$ int) ((< a7 a2)))
             (forall ((a8 int) (true))
              (forall ((_$ int) ($k2 a8 a7 a0 a1 a2))
               (and
                (forall ((a9 int) (true))
                 ($k3 a9 a0 a1 a2 a7 a8))
                (tag ((< a7 a8)) "0")
                (forall ((a10 int) (true))
                 ($k4 a10 a0 a1 a2 a7 a8))
                (tag ((< a7 a1)) "1")
                (forall ((a11 int) (true))
                 (forall ((_$ int) ($k4 a11 a0 a1 a2 a7 a8))
                  (forall ((_$ int) ((>= a11 0)))
                   (forall ((a12 int) (true))
                    (forall ((_$ int) ($k3 a12 a0 a1 a2 a7 a8))
                     (and
                      (forall ((a13 int) ((= a13 (+ a7 1))))
                       ($k1 a13 a0 a1 a2))
                      (forall ((a14 int) (true))
                       (forall ((_$ int) ($k2 a14 a7 a0 a1 a2))
                        (forall ((a15 int) ((= a15 (+ a7 1))))
                         ($k2 a14 a15 a0 a1 a2))))
                      (forall ((a16 int) (true))
                       (forall ((_$ int) ($k2 a16 a17 a0 a1 a2))
                        (forall ((a17 int) ((= a17 (+ a7 1))))
                         ($k2 a16 a7 a0 a1 a2))))))))))))))))))))))))))


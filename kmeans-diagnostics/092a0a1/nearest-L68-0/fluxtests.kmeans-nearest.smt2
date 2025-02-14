;; Tag 0: Call at 68:26: 68:29
;; Tag 1: Call at 68:18: 68:33

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
 (forall ((a0 int) (true))
  (forall ((_$ int) ((<= 0 a0)))
   (forall ((a1 int) (true))
    (forall ((_$ int) ((<= 0 a1)))
     (and
      (forall ((a2 int) (true))
       ($k0 a2 a0 a1))
      (forall ((_$ int) ((>= a1 0)))
       (and
        (forall ((a3 int) ((= a3 0)))
         (forall ((a4 int) ((= a4 0)))
          (and
           ($k1 a4 a0 a1)
           ($k2 a3 a4 a0 a1))))
        (forall ((a5 int) (true))
         (forall ((a6 int) (true))
          (forall ((_$ int) (and ($k1 a6 a0 a1) ($k2 a5 a6 a0 a1)))
           (forall ((_$ int) ((< a5 a1)))
            (and
             (forall ((a7 int) (true))
              ($k3 a7 a0 a1 a5 a6))
             (tag ((< a5 a1)) "0")
             (forall ((a8 int) (true))
              (forall ((_$ int) ($k3 a8 a0 a1 a5 a6))
               (forall ((_$ int) ((<= 0 a8)))
                (and
                 (tag ((= a0 a8)) "1")
                 (forall ((a9 bool) (true))
                  (and
                   (forall ((_$ int) ((not a9)))
                    ($k4 a6 a0 a1 a5 a6 a8 a9))
                   (forall ((_$ int) (a9))
                    ($k4 a5 a0 a1 a5 a6 a8 a9))
                   (forall ((a10 int) (true))
                    (forall ((_$ int) ($k4 a10 a0 a1 a5 a6 a8 a9))
                     (forall ((a11 int) ((= a11 (+ a5 1))))
                      (and
                       ($k1 a10 a0 a1)
                       ($k2 a11 a10 a0 a1))))))))))))))))))))))))


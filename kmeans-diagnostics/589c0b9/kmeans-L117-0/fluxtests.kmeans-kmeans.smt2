;; Tag 0: Call at 117:15: 117:38

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
(var $k0 (int int int int int)) ;; orig: $k0
(var $k1 (int int int int int int)) ;; orig: $k1

(constraint
 (forall ((a0 int) (true))
  (forall ((_$ int) ((>= a0 0)))
   (forall ((a1 int) (true))
    (forall ((_$ int) ((<= 0 a1)))
     (forall ((a2 int) (true))
      (forall ((_$ int) ((<= 0 a2)))
       (forall ((a3 int) (true))
        (and
         (forall ((a4 int) ((= a4 0)))
          ($k0 a4 a0 a1 a2 a3))
         (forall ((a5 int) (true))
          (forall ((a6 int) ((= a6 0)))
           ($k1 a5 a6 a0 a1 a2 a3)))
         (forall ((a7 int) (true))
          (forall ((_$ int) ($k0 a7 a0 a1 a2 a3))
           (forall ((_$ int) ((< a7 a3)))
            (and
             (forall ((a8 int) (true))
              (forall ((_$ int) ($k1 a8 a7 a0 a1 a2 a3))
               (tag ((= a8 a0)) "0")))
             (forall ((a9 int) (true))
              (tag ((= a9 a0)) "0"))
             (forall ((_$ int) ((<= 0 a1)))
              (and
               (forall ((a10 int) ((= a10 (+ a7 1))))
                ($k0 a10 a0 a1 a2 a3))
               (forall ((a11 int) (true))
                (forall ((_$ int) ((= a11 a0)))
                 (forall ((a12 int) ((= a12 (+ a7 1))))
                  ($k1 a11 a12 a0 a1 a2 a3)))))))))))))))))))


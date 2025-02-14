;; Tag 0: Call at 39:19: 39:22
;; Tag 1: Call at 40:10: 40:13

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
(var $k0 (int int)) ;; orig: $k0
(var $k1 (int int int)) ;; orig: $k1

(constraint
 (forall ((a0 int) (true))
  (forall ((_$ int) ((>= a0 0)))
   (and
    (forall ((a1 int) ((= a1 0)))
     ($k0 a1 a0))
    (forall ((a2 int) (true))
     (forall ((a3 int) ((= a3 0)))
      ($k1 a2 a3 a0)))
    (forall ((a4 int) (true))
     (forall ((_$ int) ($k0 a4 a0))
      (forall ((a5 int) (true))
       (forall ((_$ int) ((<= 0 a5)))
        (forall ((_$ int) ($k1 a5 a4 a0))
         (forall ((_$ int) ((>= a5 0)))
          (forall ((_$ int) ((< a4 a5)))
           (forall ((a6 int) (true))
            (forall ((_$ int) ((<= 0 a6)))
             (forall ((_$ int) ($k1 a6 a4 a0))
              (and
               (tag ((< a4 a6)) "0")
               (forall ((a7 int) (true))
                (forall ((_$ int) ($k1 a7 a4 a0))
                 (and
                  (tag ((< a4 a7)) "1")
                  (forall ((a8 int) ((= a8 (+ a4 1))))
                   ($k0 a8 a0))
                  (forall ((a9 int) (true))
                   (forall ((_$ int) ($k1 a9 a4 a0))
                    (forall ((a10 int) ((= a10 (+ a4 1))))
                     ($k1 a9 a10 a0))))
                  (forall ((a11 int) (true))
                   (forall ((_$ int) ($k1 a11 a12 a0))
                    (forall ((a12 int) ((= a12 (+ a4 1))))
                     ($k1 a11 a4 a0))))))))))))))))))))))


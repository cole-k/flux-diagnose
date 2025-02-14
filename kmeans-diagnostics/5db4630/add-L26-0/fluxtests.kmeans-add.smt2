;; Tag 0: Call at 26:19: 26:22
;; Tag 1: Call at 27:19: 27:22
;; Tag 2: Call at 28:10: 28:13

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
(var $k0 (int int int)) ;; orig: $k0
(var $k1 (int int int int)) ;; orig: $k1

(constraint
 (forall ((a0 int) (true))
  (forall ((_$ int) ((<= 0 a0)))
   (forall ((a1 int) (true))
    (forall ((_$ int) ((<= 0 a1)))
     (forall ((_$ int) ((>= a1 0)))
      (and
       (forall ((a2 int) ((= a2 0)))
        ($k0 a2 a0 a1))
       (forall ((a3 int) (true))
        (forall ((a4 int) ((= a4 0)))
         ($k1 a3 a4 a0 a1)))
       (forall ((a5 int) (true))
        (forall ((_$ int) ($k0 a5 a0 a1))
         (forall ((_$ int) ((< a5 a1)))
          (forall ((a6 int) (true))
           (forall ((_$ int) ((<= 0 a6)))
            (forall ((_$ int) ($k1 a6 a5 a0 a1))
             (and
              (tag ((< a5 a6)) "0")
              (tag ((< a5 a0)) "1")
              (forall ((a7 int) (true))
               (forall ((_$ int) ($k1 a7 a5 a0 a1))
                (and
                 (tag ((< a5 a7)) "2")
                 (forall ((a8 int) ((= a8 (+ a5 1))))
                  ($k0 a8 a0 a1))
                 (forall ((a9 int) (true))
                  (forall ((_$ int) ($k1 a9 a5 a0 a1))
                   (forall ((a10 int) ((= a10 (+ a5 1))))
                    ($k1 a9 a10 a0 a1))))
                 (forall ((a11 int) (true))
                  (forall ((_$ int) ($k1 a11 a12 a0 a1))
                   (forall ((a12 int) ((= a12 (+ a5 1))))
                    ($k1 a11 a5 a0 a1)))))))))))))))))))))


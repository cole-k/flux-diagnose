;; Tag 0: Ret at 123:1: 123:2
;; Tag 1: Ret at 123:1: 123:2
;; Tag 2: Call at 119:15: 119:38
;; Tag 3: Call at 119:15: 119:38

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
 (forall ((reftgen$n$0 int) (true))
  (forall ((reftgen$k$1 int) (true))
   (forall ((_$ int) ((>= reftgen$n$0 0)))
    (forall ((_$ int) ((<= 0 reftgen$k$1)))
     (forall ((a0 int) (true))
      (forall ((_$ int) ((<= 0 a0)))
       (forall ((a1 int) (true))
        (and
         (forall ((a2 int) ((= a2 0)))
          (forall ((a3 int) ((= a3 reftgen$k$1)))
           ($k0 a2 reftgen$n$0 a3 a0 a1)))
         (forall ((a4 int) (true))
          (forall ((_$ int) ((= a4 reftgen$n$0)))
           (forall ((a5 int) ((= a5 0)))
            (forall ((a6 int) ((= a6 reftgen$k$1)))
             ($k1 a4 a5 reftgen$n$0 a6 a0 a1)))))
         (forall ((a7 int) (true))
          (forall ((_$ int) ($k0 a7 reftgen$n$0 a8 a0 a1))
           (forall ((a8 int) ((= a8 reftgen$k$1)))
            (and
             (forall ((_$ int) ((not (< a7 a1))))
              (and
               (forall ((a9 int) (true))
                (forall ((_$ int) ($k1 a9 a7 reftgen$n$0 a10 a0 a1))
                 (forall ((a10 int) ((= a10 reftgen$k$1)))
                  (tag ((= a9 reftgen$n$0)) "0"))))
               (tag ((= reftgen$k$1 reftgen$k$1)) "1")))
             (forall ((_$ int) ((< a7 a1)))
              (and
               (tag ((and (> reftgen$k$1 0))) "2")
               (forall ((a11 int) (true))
                (forall ((_$ int) ($k1 a11 a7 reftgen$n$0 a12 a0 a1))
                 (forall ((a12 int) ((= a12 reftgen$k$1)))
                  (tag ((= a11 reftgen$n$0)) "3"))))
               (forall ((a13 int) (true))
                (forall ((_$ int) ((= a13 reftgen$n$0)))
                 (tag ((= a13 reftgen$n$0)) "3")))
               (forall ((_$ int) ((<= 0 reftgen$k$1)))
                (and
                 (forall ((a14 int) ((= a14 (+ a7 1))))
                  (forall ((a15 int) ((= a15 reftgen$k$1)))
                   ($k0 a14 reftgen$n$0 a15 a0 a1)))
                 (forall ((a16 int) (true))
                  (forall ((_$ int) ((= a16 reftgen$n$0)))
                   (forall ((a17 int) ((= a17 (+ a7 1))))
                    (forall ((a18 int) ((= a18 reftgen$k$1)))
                     ($k1 a16 a17 reftgen$n$0 a18 a0 a1))))))))))))))))))))))


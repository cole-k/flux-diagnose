;; Tag 0: Overflow at 90:13: 90:42
;; Tag 1: Ret at 87:9: 94:10
;; Tag 2: Overflow at 88:13: 88:34
;; Tag 3: Ret at 88:13: 88:34

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
(constant gt (func 1 (@(0) @(0) ) bool))
(constant ge (func 1 (@(0) @(0) ) bool))
(constant lt (func 1 (@(0) @(0) ) bool))
(constant le (func 1 (@(0) @(0) ) bool))
(var $k0 (int int int int)) ;; orig: $k0
(var $k1 (int int int int int)) ;; orig: $k1
(var $k2 (int int int int)) ;; orig: $k2

(constraint
 (forall ((reftgen$rb$0 (Tuple3 int int int)) (true))
  (forall ((_$ int) ((> (tuple3$0 reftgen$rb$0) 1)))
   (forall ((_$ int) ((> (tuple3$0 reftgen$rb$0) 1)))
    (forall ((_$ int) ((>= (tuple3$0 reftgen$rb$0) 0)))
     (forall ((_$ int) ((< (tuple3$1 reftgen$rb$0) (tuple3$0 reftgen$rb$0))))
      (forall ((_$ int) ((>= (tuple3$1 reftgen$rb$0) 0)))
       (forall ((_$ int) ((< (tuple3$2 reftgen$rb$0) (tuple3$0 reftgen$rb$0))))
        (forall ((_$ int) ((>= (tuple3$2 reftgen$rb$0) 0)))
         (and
          (forall ((_$ int) ((not (> (tuple3$2 reftgen$rb$0) (tuple3$1 reftgen$rb$0)))))
           (and
            (forall ((_$ int) ((not (< (tuple3$2 reftgen$rb$0) (tuple3$1 reftgen$rb$0)))))
             (and
              (forall ((a0 int) ((= a0 0)))
               (forall ((a1 int) ((= a1 (tuple3$0 reftgen$rb$0))))
                (forall ((a2 int) ((= a2 (tuple3$1 reftgen$rb$0))))
                 (forall ((a3 int) ((= a3 (tuple3$2 reftgen$rb$0))))
                  ($k0 a0 a1 a2 a3)))))
              (forall ((a4 int) (true))
               (forall ((a5 int) ((= a5 0)))
                (forall ((a6 int) ((= a6 (tuple3$0 reftgen$rb$0))))
                 (forall ((a7 int) ((= a7 (tuple3$1 reftgen$rb$0))))
                  (forall ((a8 int) ((= a8 (tuple3$2 reftgen$rb$0))))
                   ($k1 a4 a5 a6 a7 a8))))))))
            (forall ((_$ int) ((< (tuple3$2 reftgen$rb$0) (tuple3$1 reftgen$rb$0))))
             (and
              (forall ((a9 int) (true))
               (forall ((a10 int) ((= a10 (tuple3$0 reftgen$rb$0))))
                (forall ((a11 int) ((= a11 (tuple3$1 reftgen$rb$0))))
                 (forall ((a12 int) ((= a12 (tuple3$2 reftgen$rb$0))))
                  ($k2 a9 a10 a11 a12)))))
              (forall ((_$ int) ((>= (tuple3$0 reftgen$rb$0) 0)))
               (and
                (tag ((>= (- (tuple3$0 reftgen$rb$0) (tuple3$1 reftgen$rb$0)) 0)) "0")
                (forall ((a13 int) ((= a13 (+ (- (tuple3$0 reftgen$rb$0) (tuple3$1 reftgen$rb$0)) (tuple3$2 reftgen$rb$0)))))
                 (forall ((a14 int) ((= a14 (tuple3$0 reftgen$rb$0))))
                  (forall ((a15 int) ((= a15 (tuple3$1 reftgen$rb$0))))
                   (forall ((a16 int) ((= a16 (tuple3$2 reftgen$rb$0))))
                    ($k0 a13 a14 a15 a16)))))
                (forall ((a17 int) (true))
                 (forall ((a18 int) ((= a18 (+ (- (tuple3$0 reftgen$rb$0) (tuple3$1 reftgen$rb$0)) (tuple3$2 reftgen$rb$0)))))
                  (forall ((a19 int) ((= a19 (tuple3$0 reftgen$rb$0))))
                   (forall ((a20 int) ((= a20 (tuple3$1 reftgen$rb$0))))
                    (forall ((a21 int) ((= a21 (tuple3$2 reftgen$rb$0))))
                     ($k1 a17 a18 a19 a20 a21))))))))))
            (forall ((a22 int) (true))
             (forall ((_$ int) ($k0 a22 a23 a24 a25))
              (forall ((a23 int) ((= a23 (tuple3$0 reftgen$rb$0))))
               (forall ((a24 int) ((= a24 (tuple3$1 reftgen$rb$0))))
                (forall ((a25 int) ((= a25 (tuple3$2 reftgen$rb$0))))
                 (tag ((= a22 (mod (- (tuple3$1 reftgen$rb$0) (tuple3$2 reftgen$rb$0)) (tuple3$0 reftgen$rb$0)))) "1"))))))))
          (forall ((_$ int) ((> (tuple3$2 reftgen$rb$0) (tuple3$1 reftgen$rb$0))))
           (and
            (tag ((>= (- (tuple3$2 reftgen$rb$0) (tuple3$1 reftgen$rb$0)) 0)) "2")
            (tag ((= (- (tuple3$2 reftgen$rb$0) (tuple3$1 reftgen$rb$0)) (mod (- (tuple3$1 reftgen$rb$0) (tuple3$2 reftgen$rb$0)) (tuple3$0 reftgen$rb$0)))) "3")))))))))))))


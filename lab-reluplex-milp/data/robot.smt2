; Robot exercise: one step of a robot moving at speed v for 2 time units (Z3 / SMT-LIB2)
(set-logic QF_LRA)

(declare-fun x0 () Real)
(declare-fun x1 () Real)
(declare-fun v  () Real)

; constraints
(assert (>= x0 0))                 ; never below 0
(assert (>= x1 0))
(assert (and (>= v 0) (<= v 5)))   ; 0 ≤ v ≤ 5
(assert (= x1 (+ x0 (* 2 v))))     ; x1 = x0 + v*2
(assert (<= x0 10))                ; must reach 10 at some point
(assert (>= x1 10))                ; monotone: end reaches ≥10

(check-sat)
(get-model)

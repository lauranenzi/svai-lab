; Robot exercise: one step of a robot moving at speed v for 2 time units (Z3 / SMT-LIB2)
(set-logic QF_LRA)

(declare-fun x0 () Real)
(declare-fun x1 () Real)
(declare-fun v  () Real)

; constraints
(assert (>= x0 0))                 ; never below 0
(assert (>= x1 0))
(assert (and (>= v 0) (<= v 5)))   ; 0 ≤ v ≤ 5
(assert (= x1 (+ x0 (* 2 v))))     ; x1 = x0 + 2v
; "must reach 10 at some point": with v ≥ 0 the arm moves monotonically from x0 to x1,
; so it passes position 10 exactly when x0 ≤ 10 ≤ x1
(assert (<= x0 10))
(assert (>= x1 10))

(check-sat)
(get-model)

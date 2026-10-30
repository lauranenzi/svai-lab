; Exercise 1: a small QF_LRA formula (Z3 / SMT-LIB2)
(set-logic QF_LRA)

(declare-fun x () Real)
(declare-fun y () Real)

; (x > 1 ∨ y < 2) ∧ (x + y ≤ 4) ∧ (¬(y < 2) ∨ x ≤ 3)
(assert
 (and
   (or (> x 1) (< y 2))
   (<= (+ x y) 4)
   (or (not (< y 2)) (<= x 3))
 )
)

(check-sat)
(get-model)
(get-value (x y))

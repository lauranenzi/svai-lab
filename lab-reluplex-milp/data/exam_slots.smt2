; Exercise 2: exam-slot scheduling in pure Booleans, in CNF (Z3 / SMT-LIB2)
; Exams:  E1..E6
; Slots:  S1..S4  (S1, S2 = morning; S3, S4 = afternoon)
; Conflicts: E1-E2, E3-E4, E3-E6.  Prerequisites: E1 in the morning, E4 in the afternoon.
; Every assert below is one clause: 6 + 36 + 12 + 2 = 56 clauses.

; Boolean variables: Ei_Sj = "exam Ei is in slot Sj"
(declare-fun E1_S1 () Bool) (declare-fun E1_S2 () Bool) (declare-fun E1_S3 () Bool) (declare-fun E1_S4 () Bool)
(declare-fun E2_S1 () Bool) (declare-fun E2_S2 () Bool) (declare-fun E2_S3 () Bool) (declare-fun E2_S4 () Bool)
(declare-fun E3_S1 () Bool) (declare-fun E3_S2 () Bool) (declare-fun E3_S3 () Bool) (declare-fun E3_S4 () Bool)
(declare-fun E4_S1 () Bool) (declare-fun E4_S2 () Bool) (declare-fun E4_S3 () Bool) (declare-fun E4_S4 () Bool)
(declare-fun E5_S1 () Bool) (declare-fun E5_S2 () Bool) (declare-fun E5_S3 () Bool) (declare-fun E5_S4 () Bool)
(declare-fun E6_S1 () Bool) (declare-fun E6_S2 () Bool) (declare-fun E6_S3 () Bool) (declare-fun E6_S4 () Bool)

; 1a) Each exam in at least one slot  -- 6 clauses
(assert (or E1_S1 E1_S2 E1_S3 E1_S4))
(assert (or E2_S1 E2_S2 E2_S3 E2_S4))
(assert (or E3_S1 E3_S2 E3_S3 E3_S4))
(assert (or E4_S1 E4_S2 E4_S3 E4_S4))
(assert (or E5_S1 E5_S2 E5_S3 E5_S4))
(assert (or E6_S1 E6_S2 E6_S3 E6_S4))

; 1b) Each exam in at most one slot: never two slots at once  -- 36 clauses
; E1
(assert (or (not E1_S1) (not E1_S2)))
(assert (or (not E1_S1) (not E1_S3)))
(assert (or (not E1_S1) (not E1_S4)))
(assert (or (not E1_S2) (not E1_S3)))
(assert (or (not E1_S2) (not E1_S4)))
(assert (or (not E1_S3) (not E1_S4)))
; E2
(assert (or (not E2_S1) (not E2_S2)))
(assert (or (not E2_S1) (not E2_S3)))
(assert (or (not E2_S1) (not E2_S4)))
(assert (or (not E2_S2) (not E2_S3)))
(assert (or (not E2_S2) (not E2_S4)))
(assert (or (not E2_S3) (not E2_S4)))
; E3
(assert (or (not E3_S1) (not E3_S2)))
(assert (or (not E3_S1) (not E3_S3)))
(assert (or (not E3_S1) (not E3_S4)))
(assert (or (not E3_S2) (not E3_S3)))
(assert (or (not E3_S2) (not E3_S4)))
(assert (or (not E3_S3) (not E3_S4)))
; E4
(assert (or (not E4_S1) (not E4_S2)))
(assert (or (not E4_S1) (not E4_S3)))
(assert (or (not E4_S1) (not E4_S4)))
(assert (or (not E4_S2) (not E4_S3)))
(assert (or (not E4_S2) (not E4_S4)))
(assert (or (not E4_S3) (not E4_S4)))
; E5
(assert (or (not E5_S1) (not E5_S2)))
(assert (or (not E5_S1) (not E5_S3)))
(assert (or (not E5_S1) (not E5_S4)))
(assert (or (not E5_S2) (not E5_S3)))
(assert (or (not E5_S2) (not E5_S4)))
(assert (or (not E5_S3) (not E5_S4)))
; E6
(assert (or (not E6_S1) (not E6_S2)))
(assert (or (not E6_S1) (not E6_S3)))
(assert (or (not E6_S1) (not E6_S4)))
(assert (or (not E6_S2) (not E6_S3)))
(assert (or (not E6_S2) (not E6_S4)))
(assert (or (not E6_S3) (not E6_S4)))

; 2) Conflicts: two exams with common students are never in the same slot  -- 12 clauses
; E1 vs E2
(assert (or (not E1_S1) (not E2_S1)))
(assert (or (not E1_S2) (not E2_S2)))
(assert (or (not E1_S3) (not E2_S3)))
(assert (or (not E1_S4) (not E2_S4)))
; E3 vs E4
(assert (or (not E3_S1) (not E4_S1)))
(assert (or (not E3_S2) (not E4_S2)))
(assert (or (not E3_S3) (not E4_S3)))
(assert (or (not E3_S4) (not E4_S4)))
; E3 vs E6
(assert (or (not E3_S1) (not E6_S1)))
(assert (or (not E3_S2) (not E6_S2)))
(assert (or (not E3_S3) (not E6_S3)))
(assert (or (not E3_S4) (not E6_S4)))

; 3) Prerequisites  -- 2 clauses
(assert (or E1_S1 E1_S2))      ; E1 in the morning (S1 or S2)
(assert (or E4_S3 E4_S4))      ; E4 in the afternoon (S3 or S4)

(check-sat)
(get-value (E1_S1 E1_S2 E1_S3 E1_S4
            E2_S1 E2_S2 E2_S3 E2_S4
            E3_S1 E3_S2 E3_S3 E3_S4
            E4_S1 E4_S2 E4_S3 E4_S4
            E5_S1 E5_S2 E5_S3 E5_S4
            E6_S1 E6_S2 E6_S3 E6_S4))

; Is the timetable of the slide a model?  E1, E3, E5 in S1; E2, E6 in S2; E4 in S3
(push)
(assert E1_S1) (assert E3_S1) (assert E5_S1)
(assert E2_S2) (assert E6_S2)
(assert E4_S3)
(check-sat)
(pop)

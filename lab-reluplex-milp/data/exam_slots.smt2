; Exercise 2: exam-slot scheduling in pure Booleans (Z3 / SMT-LIB2)
; Exams:  E1..E6
; Slots:  S1..S4  (S1, S2 = morning; S3, S4 = afternoon)
; Conflicts: E1-E2, E3-E4, E3-E6.  Prerequisites: E1 in the morning, E4 in the afternoon.

; Boolean variables: Ei_Sj = "exam Ei is in slot Sj"
(declare-fun E1_S1 () Bool) (declare-fun E1_S2 () Bool) (declare-fun E1_S3 () Bool) (declare-fun E1_S4 () Bool)
(declare-fun E2_S1 () Bool) (declare-fun E2_S2 () Bool) (declare-fun E2_S3 () Bool) (declare-fun E2_S4 () Bool)
(declare-fun E3_S1 () Bool) (declare-fun E3_S2 () Bool) (declare-fun E3_S3 () Bool) (declare-fun E3_S4 () Bool)
(declare-fun E4_S1 () Bool) (declare-fun E4_S2 () Bool) (declare-fun E4_S3 () Bool) (declare-fun E4_S4 () Bool)
(declare-fun E5_S1 () Bool) (declare-fun E5_S2 () Bool) (declare-fun E5_S3 () Bool) (declare-fun E5_S4 () Bool)
(declare-fun E6_S1 () Bool) (declare-fun E6_S2 () Bool) (declare-fun E6_S3 () Bool) (declare-fun E6_S4 () Bool)

; Helper (a macro): exactly one of a, b, c, d is true
;   at least one: (or a b c d)
;   at most one:  no pair is true together
(define-fun exactly-one ((a Bool) (b Bool) (c Bool) (d Bool)) Bool
  (and (or a b c d)
       (not (or (and a b) (and a c) (and a d) (and b c) (and b d) (and c d)))))

; 1) Each exam is scheduled exactly once
(assert (exactly-one E1_S1 E1_S2 E1_S3 E1_S4))
(assert (exactly-one E2_S1 E2_S2 E2_S3 E2_S4))
(assert (exactly-one E3_S1 E3_S2 E3_S3 E3_S4))
(assert (exactly-one E4_S1 E4_S2 E4_S3 E4_S4))
(assert (exactly-one E5_S1 E5_S2 E5_S3 E5_S4))
(assert (exactly-one E6_S1 E6_S2 E6_S3 E6_S4))

; 2) Conflicts: two exams with common students are never in the same slot
; E1 vs E2
(assert (not (and E1_S1 E2_S1)))
(assert (not (and E1_S2 E2_S2)))
(assert (not (and E1_S3 E2_S3)))
(assert (not (and E1_S4 E2_S4)))
; E3 vs E4
(assert (not (and E3_S1 E4_S1)))
(assert (not (and E3_S2 E4_S2)))
(assert (not (and E3_S3 E4_S3)))
(assert (not (and E3_S4 E4_S4)))
; E3 vs E6
(assert (not (and E3_S1 E6_S1)))
(assert (not (and E3_S2 E6_S2)))
(assert (not (and E3_S3 E6_S3)))
(assert (not (and E3_S4 E6_S4)))

; 3) Prerequisites
(assert (or E1_S1 E1_S2))      ; E1 in the morning (S1 or S2)
(assert (or E4_S3 E4_S4))      ; E4 in the afternoon (S3 or S4)

(check-sat)

; Readable output: the slot number of each exam
(define-fun slot ((a Bool) (b Bool) (c Bool) (d Bool)) Int
  (ite a 1 (ite b 2 (ite c 3 4))))
(define-fun E1 () Int (slot E1_S1 E1_S2 E1_S3 E1_S4))
(define-fun E2 () Int (slot E2_S1 E2_S2 E2_S3 E2_S4))
(define-fun E3 () Int (slot E3_S1 E3_S2 E3_S3 E3_S4))
(define-fun E4 () Int (slot E4_S1 E4_S2 E4_S3 E4_S4))
(define-fun E5 () Int (slot E5_S1 E5_S2 E5_S3 E5_S4))
(define-fun E6 () Int (slot E6_S1 E6_S2 E6_S3 E6_S4))
(get-value (E1 E2 E3 E4 E5 E6))

; Is the timetable of the slide a model?  E1, E3, E5 in S1; E2, E6 in S2; E4 in S3
(push)
(assert (and E1_S1 E3_S1 E5_S1 E2_S2 E6_S2 E4_S3))
(check-sat)
(pop)

#lang racket

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
(display "IF:")
(newline)
(if #f
    (display "True Branch\n") 
    (display "False Branch"))

(newline)
(display "NEW-IF:")
(newline)
(new-if #f
        (display "True Branch\n")
        (display "False Branch"))

;IF:
;False Branch
;NEW-IF:
;True Branch
;False Branch
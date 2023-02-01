#lang racket

(define (sum-my-list lst)
  (cond
    ((null? lst) 0)
    (else (+ (car lst) (sum-my-list (cdr lst))))))
    

(sum-my-list '(1 2 3 4 5))
; Ausgabe: 15
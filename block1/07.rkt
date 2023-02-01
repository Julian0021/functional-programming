#lang racket

(require rackunit)

(define (my-find lst x)
  (cond
    ((null? lst) #f)
    ((equal? (car lst) x) #t)
    (else (my-find (cdr lst) x))))

(my-find '(1 2 3 4 5) 3) ; #t
(check-equal? (my-find '(1 2 3 4 5) 3) #t)

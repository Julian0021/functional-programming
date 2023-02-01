#lang racket

(require rackunit)

(define (my-reverse lst)
  (cond
    ((null? lst) '())
    (else (append (my-reverse (cdr lst)) (list (car lst))))))

(check-equal?
 (my-reverse '(1 2 3 4 5))
 '(5 4 3 2 1))
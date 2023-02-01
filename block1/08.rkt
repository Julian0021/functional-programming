#lang racket

(require rackunit)

(define (square-my-list lst)
  (cond
    ((null? lst) '())
    (else (cons (* (car lst) (car lst))
                (square-my-list (cdr lst))))))

(square-my-list '(1 2 3 4 5))
(check-equal? (square-my-list '(1 2 3 4 5)) '(1 4 9 16 25))
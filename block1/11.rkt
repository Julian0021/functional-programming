#lang racket

(require rackunit)

(define (my-map func lst)
  (foldr (lambda (x y) (cons (func x) y)) '() lst))

(check-equal? (my-map sqr '(1 2 123)) (map sqr '(1 2 123)))
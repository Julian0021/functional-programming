#lang racket

(require rackunit)

(define-syntax-rule (infix x op y)
  (op x y))

(check-equal? (infix 1 + 2) 3)
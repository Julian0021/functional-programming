#lang racket
(require rackunit)

(define (sum term a next b)
  (cond
    [(> a b) 0]
    [else (+ (term a) (sum term (next a) next b))]))

(define (my-sum term a next b)
  (define (f term a next b acc)
    (cond
      [(> a b) acc]
      [else (f term (next a) next b (+ (term a) acc))]))
  (f term a next b 0))


(check-equal? (my-sum (lambda (x) x) 1 (lambda (x) (+ x 1)) 10) (sum (lambda (x) x) 1 (lambda (x) (+ x 1)) 10))
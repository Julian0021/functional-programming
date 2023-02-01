#lang racket

(define x 5)

(define (beispiel)
  (define x 3)
  (+ x 2))

(define (beispiel2)
  (+ x 2))

(beispiel) ; 5
(beispiel2) ; 7



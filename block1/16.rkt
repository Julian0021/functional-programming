#lang racket

(require rackunit)

; Schreiben Sie eine Funktion ‘repeated, die eine Funktion f und eine natürliche Zahl n erhält und dann f n-mal ausführt.

(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      (lambda (x) (f ((repeated f (- n 1)) x)))))

(check-equal? ((repeated sqr 2) 3) 81)
(check-equal? ((repeated add1 10) 1) 11)
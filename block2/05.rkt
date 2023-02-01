#lang racket

(require rackunit)

; Erstellt einen Stream
(define (fib-stream)
  (let fib-helper ([n 0] [prev 0] [cur 1])
    (cons (list n prev) (delay (fib-helper (add1 n) cur (+ prev cur))))))

; Gibt den ausgewerteten Rest eines Streams zurück
(define (tail s) (force (cdr s)))

; Tests
(define a (fib-stream))
(check-equal? (car a) '(0 0))
(check-equal? (car (tail a)) '(1 1))
(check-equal? (car (tail (tail a))) '(2 1))
(check-equal? (car (tail (tail (tail a)))) '(3 2))
(check-equal? (car (tail (tail (tail (tail a))))) '(4 3))
(check-equal? (car (tail (tail (tail (tail (tail a)))))) '(5 5))



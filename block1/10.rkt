#lang racket

(define (square-list lst)
(define (sqrIteration lst accumulator)
    (if (null? lst)
        accumulator
        (sqrIteration (cdr lst) (append accumulator (list (sqr (car lst)))))))
    (sqrIteration lst '()))

;Beispiel
(square-list '(1 2 3 123))


(define (sum lst)
(define (sumIteration lst accumulator)
    (if (null? lst)
        accumulator
        (sumIteration (cdr lst) (+ accumulator (car lst)))))
    (sumIteration lst 0))

;Beispiel
(sum '(1 2 3))
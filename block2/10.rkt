#lang typed/racket

(require typed/rackunit)

(: my-map (All (T U) (-> (-> T U) (Listof T) (Listof U))))
(define (my-map f lst)
  (if (null? lst) '() (cons (f (car lst)) (my-map f (cdr lst)))))

(: my-foldr (All (T U) (-> (-> T U U) U (Listof T) U)))
(define (my-foldr f init lst)
  (if (null? lst) init (f (car lst) (my-foldr f init (cdr lst)))))

(check-equal? (my-map add1 '(1 2 3 4)) '(2 3 4 5))

(check-equal? (my-foldr - 0 '(1 2 3 4)) (- 1 (- 2 (- 3 (- 4 0)))))
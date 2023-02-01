#lang racket

(require rackunit)
 
(define (insert-sort l)
  (define (insert x l)
    (cond
      [(null? l) (list x)]
      [(< x (car l)) (cons x l)]
      [else (cons (car l) (insert x (cdr l)))]))
  (cond
    [(null? l) '()]
    [else (insert (car l) (insert-sort (cdr l)))]))

(check-equal? (insert-sort '(2 4 1 6 4)) '(1 2 4 4 6))
(check-equal? (insert-sort '()) '())
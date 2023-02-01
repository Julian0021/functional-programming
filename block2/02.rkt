#lang racket

(require rackunit)

(define (flatten lst)
  (define (f lst acc)
    (cond
      [(null? lst) acc]
      [(pair? lst) (f (car lst) (f (cdr lst) acc))]
      [else (cons lst acc)]))
  (f lst '()))

(check-equal? (flatten '((a) b (c (d)  e) ())) '(a b c d e))
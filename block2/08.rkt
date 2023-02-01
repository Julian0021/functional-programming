#lang typed/racket

(: bar (-> (U Integer Boolean String) Integer))
(define (bar x)
  (cond
    [(number? x) (string-length (number->string x))]
    [(boolean? x) 1]
    [else (string-length x)]))

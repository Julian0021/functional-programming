#lang typed/racket

(require typed/rackunit)

(: square-my-list (-> (Listof Number) (Listof Number)))
(define (square-my-list lst)
  (if (null? lst) '() (cons (sqr (car lst)) (square-my-list (cdr lst)))))


(: sum-my-list :  (Listof Integer) -> Integer)
(define (sum-my-list lst)
  (foldl + 0 lst))

(: my-find :  (Listof Any) Any -> Boolean)
(define (my-find lst x)
  (if (null? lst)
      #f
      (if (equal? (car lst) x)
          #t
          (my-find (cdr lst) x))))

(: my-reverse :  (Listof Any) -> (Listof Any))
(define (my-reverse lst)
  (cond
    [(empty? lst) empty]
    [else (append (my-reverse (rest lst))
                  (list (first lst)))]))


(check-equal? (square-my-list '(1 2 3 4)) '(1 4 9 16))
(check-equal? (sum-my-list '(1 2 3 4)) 10)
(check-equal? (my-find '(1 2 3 4) 3) #t)
(check-equal? (my-find '(1 2 3 4) 187) #f)
(check-equal? (my-reverse '(1 2 3 4)) '(4 3 2 1))
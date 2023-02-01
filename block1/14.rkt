#lang racket

(require rackunit)

; Berechnet die Mehrwertsteuer
(define (calculate-vat price)
  (* price 1.19))

; Beispiel:
(calculate-vat 100) ; 119

(check-equal? (calculate-vat 100) 119)

; FizzBuzz: Gibt "Fizz" aus, wenn die Zahl durch 3 teilbar ist, "Buzz", wenn sie durch 5 teilbar ist und "FizzBuzz", wenn sie durch 15 teilbar ist. Ansonsten wird die Zahl ausgegeben.
(define (fizzbuzz)
  (lambda (n)
    (cond
      [(= (modulo n 15) 0) "FizzBuzz"]
      [(= (modulo n 3) 0) "Fizz"]
      [(= (modulo n 5) 0) "Buzz"]
      [else n])))


((fizzbuzz) 15) ; "FizzBuzz"
((fizzbuzz) 3) ; "Fizz"
((fizzbuzz) 5) ; "Buzz"
((fizzbuzz) 7) ; 7

(check-equal? ((fizzbuzz) 15) "FizzBuzz")
(check-equal? ((fizzbuzz) 3) "Fizz")
(check-equal? ((fizzbuzz) 5) "Buzz")
(check-equal? ((fizzbuzz) 7) 7)
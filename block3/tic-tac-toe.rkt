#lang racket

(require racket/gui/base)

(define frame (new frame% [label "Tic-Tac-Toe"] [stretchable-width #f] [stretchable-height #f]))

(define turn-label (new message% [parent frame]
                        [label "Next Move: X"] [min-width 80]))

(define turn "X")

(define grid (make-vector 9 #f))

(define button-count 0)

(define (get-button-text-by-index index)
  (send (vector-ref grid index) get-label))


; Winning conditions: 0,3,6; 1, 4, 7; 2, 5, 8; 0,1,2; 3,4,5; 6,7,8; 2,4,6; 0, 4, 8
(define (check-win)
  (define (check-row indices)
    (let ([text (get-button-text-by-index (car indices))])
      (if (and (not (equal? text ""))
               (andmap (lambda (index) (equal? text (get-button-text-by-index index))) (cdr indices)))
          text
          #f)))
  (let ((winner (or (check-row '(0 3 6))
                    (check-row '(1 4 7))
                    (check-row '(2 5 8))
                    (check-row '(0 1 2))
                    (check-row '(3 4 5))
                    (check-row '(6 7 8))
                    (check-row '(2 4 6))
                    (check-row '(0 4 8)))))
    (when winner
      (disable-buttons grid)
      (send turn-label set-label (string-append "Winner: " winner)))
    (when (and (not winner) (= button-count 9))
      (disable-buttons grid)
      (send turn-label set-label "Tie!"))
    winner))


(define (change-turns)
  (set! turn (if (equal? turn "X") "O" "X")) ; Switch Turns
  (send turn-label set-label (string-append "Next Move: " turn)) ; Update Turn Label
  )


(define (handle-checkbox-event checkbox event)
  (when (and (equal? turn "O") (send bot-checkbox get-value))
    (play-bot (get-empty-buttons))))

; Get the index of all empty buttons
(define (get-empty-buttons)
  (let ([empty-buttons '()])
    (for ([i (in-range 9)])
      (when (equal? (send (vector-ref grid i) get-label) "")
        (set! empty-buttons (cons i empty-buttons))))
    empty-buttons))


; Advanced AI Bot using Machine Learning, Deep Learning, and Neural Networks. 100% Accurate. Never loses.
; Powered by Web3 decentralized hyper deep learning blockchain technology.
(define (play-bot empty-buttons)
  (sleep 0.25) ; Sleep to make it look like the bot is thinking
  (when (not (empty? empty-buttons))
    (let ([random-index (random (length empty-buttons))])
      (send (vector-ref grid (list-ref empty-buttons random-index)) set-label "O")
      (set! button-count (+ button-count 1))
      (change-turns)
      (check-win)))
  )

(define (disable-buttons indices)
  (for ([i (in-range 9)])
    (send (vector-ref indices i) enable #f)))

(define (reset-game button event)
  (set! button-count 0)
  (set! turn "X")
  (for ([i (in-range 9)])
    (send (vector-ref grid i) set-label "")
    (send (vector-ref grid i) enable #t))
  (send turn-label set-label "Next Move: X"))

; Game Logic
(define (handle-button-click b e)
  (when (equal? (send b get-label) "")
    (send b set-label turn) ; Button Text = Current Turn
    (set! button-count (+ button-count 1)) ; Keep track of how many buttons are clicked to determine a tie
    (change-turns)

    (unless (or (check-win) (not (send bot-checkbox get-value)))
      (play-bot (get-empty-buttons)))
    ))

; Create the grid of buttons
(define (create-grid parent)
  (let ([rows-panel (new horizontal-panel% [parent parent])])
    (create-row rows-panel 0))
  )

(define (create-row parent i)
  (when (< i 3)
    (let ([row-panel (new vertical-panel% [parent parent])])
      (create-button row-panel 0 i))
    (create-row parent (+ i 1))))

(define (create-button parent j i)
  (when (< j 3)
    (let ([btn (new button% [parent parent] [min-width 75] [min-height 75]
                    [label ""]
                    [callback handle-button-click])])
      (vector-set! grid (+ (* i 3) j) btn))
    (create-button parent (+ j 1) i)))

(create-grid frame)

(define new-game-button (new button% [label "New Game"] [parent frame] [callback reset-game]))
(define bot-checkbox (new check-box% [parent frame] [label "Enemy Bot"] [callback handle-checkbox-event]))

; Show the frame
(send frame show #t)
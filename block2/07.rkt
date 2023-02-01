#lang racket

(require rackunit)

(define (mk-mp3-control)
  (define mp3-files '())
  (define selected-file-index 0)
  (define playing? #f)

  ; load: Laden einer Datei in die Liste (Übergabe des Dateinamens und der Dauer des Stücks)
  (define (load song-name song-length)
    (set! mp3-files (append mp3-files (list (cons song-name song-length)))))

  ; delete: Löschen einer Datei aus der Liste (Übergabe des Indexes der Datei in der Liste)
  (define (delete index)
    (cond [(= index selected-file-index) (set! selected-file-index 0)])
    (set! mp3-files (remove (list-ref mp3-files index) mp3-files)))

  ; toggle-play: Umschalten zwischen Play und Stop
  (define (toggle-play)
    (set! playing? (not playing?)))

  ; next: Wechsel auf den nächsten Titel
  (define (next)
    (define next-index (+ selected-file-index 1))
    (cond [(> (length mp3-files) next-index) (set! selected-file-index next-index)]))

  ; prev: Wechsel auf den vorherigen Titel
  (define (prev)
    (define prev-index (- selected-file-index 1))
    (cond [(>= prev-index 0) (set! selected-file-index prev-index)]))

  ; die folgenden Methoden sind nur für die Ausgabe der Daten gedacht
  (define (get-mp3-files) mp3-files)
  (define (get-file-count) (length mp3-files))
  (define (get-selected-file)
    (cond [(= (length mp3-files) 0) null]
          [else (list-ref mp3-files selected-file-index)]))

  ; play-state: Gibt den aktuellen Status zurück (Play oder Stop)
  (define (play-state)
    (if playing?
        (get-selected-file)
        "stop"))

  (define (dispatch m)
    (cond
      ((equal? m 'load) load)
      ((equal? m 'delete) delete)
      ((equal? m 'toggle-play) toggle-play)
      ((equal? m 'next) next)
      ((equal? m 'prev) prev)
      ((equal? m 'get-mp3-files) get-mp3-files)
      ((equal? m 'get-file-count) get-file-count)
      ((equal? m 'get-selected-file) get-selected-file)
      ((equal? m 'play-state) play-state)))

  dispatch)


(define mp3-control (mk-mp3-control))

; Ein paar Songs laden
((mp3-control 'load) "song1" 3)
((mp3-control 'load) "song2" 4)
((mp3-control 'load) "song3" 5)

; Unit Tests
(check-equal? ((mp3-control 'get-file-count)) 3)
(check-equal? ((mp3-control 'get-selected-file)) (cons "song1" 3))
(check-equal? ((mp3-control 'play-state)) "stop")

((mp3-control 'toggle-play))
(check-equal? ((mp3-control 'play-state)) (cons "song1" 3))
((mp3-control 'next))
(check-equal? ((mp3-control 'play-state)) (cons "song2" 4))
((mp3-control 'prev))
(check-equal? ((mp3-control 'play-state)) (cons "song1" 3))
((mp3-control 'delete) 1)
(check-equal? ((mp3-control 'get-file-count)) 2)



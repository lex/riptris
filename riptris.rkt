#lang racket/gui

(require "settings.rkt" "colors.rkt" "riptrominos.rkt" "drawing.rkt")


(define frame (new frame%
                   [label "riptris"]
                   [width WINDOW-WIDTH]
                   [height WINDOW-HEIGHT]))

(define falling-riptromino (t-riptromino))
;; (define fallen-blocks (make-list BOARD-HEIGHT (make-vector BOARD-WIDTH 0)))
(define fallen-blocks
  (list
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 0 0 0 0)
   (vector 0 0 0 0 0 0 1 0 0 0)
   (vector 0 0 0 1 0 0 1 0 0 0)
   (vector 0 1 0 1 0 0 1 1 0 1)
   (vector 1 1 1 1 1 0 1 0 1 0)))

;; convert ones to orange blocks
(for-each
 (lambda (row)
   (for ([i (in-range 0 (vector-length row))])
     (when (equal? (vector-ref row i) 1)
       (vector-set! row i (block COLOR-ORANGE))))) fallen-blocks)

(define my-canvas%
  (class canvas%
    (define/override (on-char event)
      (define key (send event get-key-code))
      (cond
        ([equal? key 'left] (send falling-riptromino move-left))
        ([equal? key 'right] (send falling-riptromino move-right))
        ([equal? key 'up] (send falling-riptromino rotate))
        ([equal? key 'down] (send falling-riptromino move-down)))
      (send this refresh))
    (super-new)))

(new my-canvas% [parent frame]
     [paint-callback
      (lambda (canvas dc)
        (send canvas set-canvas-background COLOR-BACKGROUND)
        (send dc set-scale 3 3)
        (draw-game dc fallen-blocks falling-riptromino))])

(send frame show #t)

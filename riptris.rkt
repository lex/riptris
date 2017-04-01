#lang racket/gui

(define WIDTH 640)
(define HEIGHT 480)
(define BACKGROUND-COLOR (make-object color% 34 34 34))

(define frame (new frame%
                   [label "riptris"]
                   [width WIDTH]
                   [height HEIGHT]))

(new canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (send canvas set-canvas-background )
                (send dc set-scale 3 3)
                (send dc set-text-foreground "blue")
                (send dc draw-text "Don't Panic!" 0 0))])

(send frame show #t)
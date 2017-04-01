#lang racket/gui

(define WIDTH 640)
(define HEIGHT 480)

(define COLOR-BACKGROUND (make-object color% 39 40 34))
(define COLOR-ORANGE (make-object color% 253 135 36))
(define COLOR-PINK (make-object color% 253 138 214))
(define COLOR-CYAN (make-object color% 107 216 236))
(define COLOR-GREEN (make-object color% 166 223 64))
(define COLOR-RED (make-object color% 240 44 94))
(define COLOR-YELLOW (make-object color% 222 218 123))
(define COLOR-PURPLE (make-object color% 174 131 244))
(define COLOR-BLOCK-EDGE (make-object color% 0 0 0))

(define BLOCK-WIDTH 7)
(define BLOCK-HEIGHT BLOCK-WIDTH)
(define BLOCK-EDGE-RADIUS -0.12)
(define BLOCK-BORDER-WIDTH 0.5)

(define frame (new frame%
                   [label "riptris"]
                   [width WIDTH]
                   [height HEIGHT]))

(define (draw-block dc x y color)
  (send dc set-brush color 'solid)
  (send dc set-pen COLOR-BLOCK-EDGE BLOCK-BORDER-WIDTH 'hilite)
  (send dc draw-rounded-rectangle x y BLOCK-WIDTH BLOCK-HEIGHT BLOCK-EDGE-RADIUS))

(new canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (send canvas set-canvas-background COLOR-BACKGROUND)
                (send dc set-scale 3 3)
                (draw-block dc (* 0 BLOCK-WIDTH) 0 COLOR-ORANGE)
                (draw-block dc (* 1 BLOCK-WIDTH) 0 COLOR-PINK)
                (draw-block dc (* 2 BLOCK-WIDTH) 0 COLOR-CYAN)
                (draw-block dc (* 3 BLOCK-WIDTH) 0 COLOR-GREEN)
                (draw-block dc (* 4 BLOCK-WIDTH) 0 COLOR-RED)
                (draw-block dc (* 5 BLOCK-WIDTH) 0 COLOR-YELLOW)
                (draw-block dc (* 6 BLOCK-WIDTH) 0 COLOR-PURPLE))])

(send frame show #t)
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

(define COLOR-GAME-BORDER (make-object color% 207 207 195))
(define COLOR-BLOCK-EDGE (make-object color% 0 0 0))

(define BLOCK-WIDTH 7)
(define BLOCK-HEIGHT BLOCK-WIDTH)
(define BLOCK-EDGE-RADIUS -0.12)
(define BLOCK-BORDER-WIDTH 0.5)

(define BOARD-WIDTH 10)
(define BOARD-HEIGHT 20)

(define frame (new frame%
                   [label "riptris"]
                   [width WIDTH]
                   [height HEIGHT]))

(struct block (color))

(define (draw-block dc x y color)
  (send dc set-brush color 'solid)
  (send dc set-pen COLOR-BLOCK-EDGE BLOCK-BORDER-WIDTH 'hilite)
  (send dc draw-rounded-rectangle x y BLOCK-WIDTH BLOCK-HEIGHT BLOCK-EDGE-RADIUS))

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

(define (draw-game dc fallen)
  ;; draw borders
  ;; figure out a nicer way to do this
  (define row-length (vector-length (list-ref fallen 0)))

  (for ([x (in-range 0 (+ row-length 2))])
    (draw-block dc (* x BLOCK-WIDTH) 0 COLOR-GAME-BORDER)
    (draw-block dc (* x BLOCK-WIDTH) (* (+ (length fallen) 1) BLOCK-HEIGHT) COLOR-GAME-BORDER))

  (for ([y (in-range 1 (+ (length fallen) 1))])
    (draw-block dc 0 (* y BLOCK-HEIGHT) COLOR-GAME-BORDER)
    (draw-block dc (* (+ row-length 1) BLOCK-WIDTH) (* y BLOCK-HEIGHT) COLOR-GAME-BORDER))

  ;; draw blocks
  (for ([y (in-range 0 (length fallen))])
    (define row (list-ref fallen y))

    (for ([x (in-range 0 (vector-length row))])
      (define potential-block (vector-ref row x))
      (when (block? potential-block)
        (define drawing-x (* (+ x 1) BLOCK-WIDTH))
        (define drawing-y (* (+ y 1) BLOCK-WIDTH))
        (define drawing-color (block-color potential-block))
        (draw-block dc drawing-x drawing-y drawing-color)))))

(new canvas% [parent frame]
     [paint-callback
      (lambda (canvas dc)
        (send canvas set-canvas-background COLOR-BACKGROUND)
        (send dc set-scale 3 3)
        (draw-game dc fallen-blocks))])

(send frame show #t)

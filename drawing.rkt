#lang racket

(require "colors.rkt" "settings.rkt" "riptromino.rkt")

(provide draw-game)
(provide draw-block)

(define (draw-game dc fallen-blocks falling-riptromino)
  ;; draw borders
  ;; figure out a nicer way to do this
  (define row-length (vector-length (list-ref fallen-blocks 0)))

  (for ([x (in-range 0 (+ row-length 2))])
    (draw-block dc (* x BLOCK-WIDTH) 0 COLOR-GAME-BORDER)
    (draw-block dc (* x BLOCK-WIDTH) (* (+ (length fallen-blocks) 1) BLOCK-HEIGHT) COLOR-GAME-BORDER))

  (for ([y (in-range 1 (+ (length fallen-blocks) 1))])
    (draw-block dc 0 (* y BLOCK-HEIGHT) COLOR-GAME-BORDER)
    (draw-block dc (* (+ row-length 1) BLOCK-WIDTH) (* y BLOCK-HEIGHT) COLOR-GAME-BORDER))

  ;; draw fallen blocks
  (draw-blocks dc fallen-blocks 0 0)

  ;; draw falling blocks
  (define falling-blocks (send falling-riptromino blocks))
  (define falling-x-offset (send falling-riptromino get-x))
  (define falling-y-offset (send falling-riptromino get-y))
  (draw-blocks dc falling-blocks falling-x-offset falling-y-offset))

(define (draw-blocks dc blocks x-offset y-offset)
  (for ([y (in-range 0 (length blocks))])
    (define row (list-ref blocks y))

    (for ([x (in-range 0 (vector-length row))])
      (define potential-block (vector-ref row x))
      (when (block? potential-block)
        (define drawing-x (* (+ x x-offset 1) BLOCK-WIDTH))
        (define drawing-y (* (+ y y-offset 1) BLOCK-WIDTH))
        (define drawing-color (block-color potential-block))
        (draw-block dc drawing-x drawing-y drawing-color)))))

(define (draw-block dc x y color)
  (send dc set-brush color 'solid)
  (send dc set-pen COLOR-BLOCK-EDGE BLOCK-BORDER-WIDTH 'hilite)
  (send dc draw-rounded-rectangle x y BLOCK-WIDTH BLOCK-HEIGHT BLOCK-EDGE-RADIUS))

#lang racket

(require "riptromino.rkt" "colors.rkt")

(provide t-riptromino i-riptromino o-riptromino l-riptromino j-riptromino s-riptromino z-riptromino)
(provide (struct-out block))

(define (t-riptromino)
  (new riptromino%
       [color COLOR-GREEN]
       [rotations
        (list
         (list
          (vector 0 1 0 0)
          (vector 1 1 1 0)
          (vector 0 0 0 0)
          (vector 0 0 0 0))

         (list
          (vector 0 1 0 0)
          (vector 0 1 1 0)
          (vector 0 1 0 0)
          (vector 0 0 0 0))

         (list
          (vector 0 0 0 0)
          (vector 1 1 1 0)
          (vector 0 1 0 0)
          (vector 0 0 0 0))

         (list
          (vector 0 1 0 0)
          (vector 1 1 0 0)
          (vector 0 1 0 0)
          (vector 0 0 0 0)))]))

(define (i-riptromino)
  (new riptromino%
       [color COLOR-CYAN]
       [rotations
        (list
         (list
          (vector 0 1 0 0)
          (vector 0 1 0 0)
          (vector 0 1 0 0)
          (vector 0 1 0 0))

         (list
          (vector 0 0 0 0)
          (vector 1 1 1 1)
          (vector 0 0 0 0)
          (vector 0 0 0 0)))]))

(define (o-riptromino)
  (new riptromino%
       [color COLOR-YELLOW]
       [rotations
        (list
         (list
          (vector 1 1 0 0)
          (vector 1 1 0 0)
          (vector 0 0 0 0)
          (vector 0 0 0 0)))]))

(define (l-riptromino)
  (new riptromino%
       [color COLOR-ORANGE]
       [rotations
        (list
         (list
          (vector 1 0 0 0)
          (vector 1 0 0 0)
          (vector 1 1 0 0)
          (vector 0 0 0 0))

         (list
          (vector 0 0 0 0)
          (vector 1 1 1 0)
          (vector 1 0 0 0)
          (vector 0 0 0 0))

         (list
          (vector 1 1 0 0)
          (vector 0 1 0 0)
          (vector 0 1 0 0)
          (vector 0 0 0 0))

         (list
          (vector 0 0 1 0)
          (vector 1 1 1 0)
          (vector 0 0 0 0)
          (vector 0 0 0 0)))]))

(define (j-riptromino)
  (new riptromino%
       [color COLOR-BLUE]
       [rotations
        (list
         (list
          (vector 0 1 0 0)
          (vector 0 1 0 0)
          (vector 1 1 0 0)
          (vector 0 0 0 0))

         (list
          (vector 1 0 0 0)
          (vector 1 1 1 0)
          (vector 0 0 0 0)
          (vector 0 0 0 0))

         (list
          (vector 1 1 0 0)
          (vector 1 0 0 0)
          (vector 1 0 0 0)
          (vector 0 0 0 0))

         (list
          (vector 0 0 0 0)
          (vector 1 1 1 0)
          (vector 0 0 1 0)
          (vector 0 0 0 0)))]))

(define (s-riptromino)
  (new riptromino%
       [color COLOR-GREEN]
       [rotations
        (list
         (list
          (vector 0 1 1 0)
          (vector 1 1 0 0)
          (vector 0 0 0 0)
          (vector 0 0 0 0))

         (list
          (vector 1 0 0 0)
          (vector 1 1 0 0)
          (vector 0 1 0 0)
          (vector 0 0 0 0)))]))

(define (z-riptromino)
  (new riptromino%
       [color COLOR-RED]
       [rotations
        (list
         (list
          (vector 1 1 0 0)
          (vector 0 1 1 0)
          (vector 0 0 0 0)
          (vector 0 0 0 0))

         (list
          (vector 0 1 0 0)
          (vector 1 1 0 0)
          (vector 1 0 0 0)
          (vector 0 0 0 0)))]))

#lang racket

(require "riptromino.rkt" "colors.rkt")

(provide t-riptromino)
(provide (struct-out block))

(define (t-riptromino)
  (new riptromino%
       [color COLOR-GREEN]
       [rotations
        (list
         (list
          (vector 0 0 0 0)
          (vector 0 1 0 0)
          (vector 1 1 1 0)
          (vector 0 0 0 0))

         (list
          (vector 0 0 0 0)
          (vector 0 1 0 0)
          (vector 0 1 1 0)
          (vector 0 1 0 0))

         (list
          (vector 0 0 0 0)
          (vector 0 0 0 0)
          (vector 1 1 1 0)
          (vector 0 1 0 0))

         (list
          (vector 0 0 0 0)
          (vector 0 1 0 0)
          (vector 1 1 0 0)
          (vector 0 1 0 0)))]))

#lang racket

(provide WINDOW-WIDTH)
(provide WINDOW-HEIGHT)
(provide BOARD-WIDTH)
(provide BOARD-HEIGHT)
(provide BLOCK-WIDTH)
(provide BLOCK-HEIGHT)
(provide BLOCK-EDGE-RADIUS)
(provide BLOCK-BORDER-WIDTH)
(provide INITIAL-FALL-INTERVAL)

(define WINDOW-WIDTH 640)
(define WINDOW-HEIGHT 480)

(define BOARD-WIDTH 10)
(define BOARD-HEIGHT 20)

(define BLOCK-WIDTH 7)
(define BLOCK-HEIGHT BLOCK-WIDTH)
(define BLOCK-EDGE-RADIUS -0.12)
(define BLOCK-BORDER-WIDTH 0.5)

;; Game speed (milliseconds between falls)
(define INITIAL-FALL-INTERVAL 1000)

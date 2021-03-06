#lang racket/gui

(provide COLOR-GAME-BORDER)
(provide COLOR-BLOCK-EDGE)
(provide COLOR-BACKGROUND)
(provide COLOR-ORANGE)
(provide COLOR-PINK)
(provide COLOR-CYAN)
(provide COLOR-GREEN)
(provide COLOR-RED)
(provide COLOR-YELLOW)
(provide COLOR-PURPLE)

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

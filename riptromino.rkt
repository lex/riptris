#lang racket

(provide riptromino%)
(provide (struct-out block))

(struct block (color))

(define riptromino%
  (class object%
    (super-new)
    (init-field color)
    (init-field rotations)

    ;; replace ones with colored blocks
    (for-each
     (lambda (rotation)
       (for-each
        (lambda (row)
          (for ([b (in-range 0 (vector-length row))])
            (when (equal? (vector-ref row b) 1)
              (vector-set! row b (block color))))) rotation)) rotations)

    (define rotation-index 0)
    (define x 0)
    (define y 0)

    (define/public (get-x) x)
    (define/public (get-y) y)

    (define/public (tick)
      ;; collision detection where
      (set! y (+ y 1)))

    (define/public (move-left)
      ;; collision detection where
      (set! x (- x 1)))

    (define/public (move-right)
      ;; collision detection where
      (set! x (+ x 1)))

    (define/public (move-down)
      ;; collision detection where
      (set! y (+ y 1)))

    (define/public (rotate)
      ;; collision detection where
      (set! rotation-index
            (cond
              [(equal? rotation-index (- (length rotations) 1)) 0]
              [else (+ rotation-index 1)])))

    (define/public (blocks)
      (list-ref rotations rotation-index))))

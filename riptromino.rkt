#lang racket
(require "settings.rkt")

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

    (define/public (tick fallen-blocks)
      (unless (or (out-of-bounds? fallen-blocks x (+ y 1)) (collision? fallen-blocks x (+ y 1)))
        (set! y (+ y 1))))

    (define/public (move-left fallen-blocks)
      (unless (or (out-of-bounds? fallen-blocks (- x 1) y) (collision? fallen-blocks (- x 1) y))
        (set! x (- x 1))))

    (define/public (move-right fallen-blocks)
      (unless (or (out-of-bounds? fallen-blocks (+ x 1) y) (collision? fallen-blocks (+ x 1) y))
        (set! x (+ x 1))))

    (define/public (move-down fallen-blocks)
      (unless (or (out-of-bounds? fallen-blocks x (+ y 1)) (collision? fallen-blocks x (+ y 1)))
        (set! y (+ y 1))))

    (define/public (rotate fallen-blocks)
      (define new-rotation-index
        (cond
          [(equal? rotation-index (- (length rotations) 1)) 0]
          [else (+ rotation-index 1)]))
      (let ([old-rotation-index rotation-index])
        (set! rotation-index new-rotation-index)
        (if (or (out-of-bounds? fallen-blocks x y) (collision? fallen-blocks x y))
            (set! rotation-index old-rotation-index)
            (set! rotation-index new-rotation-index))))

    (define/public (out-of-bounds? fallen-blocks x y)
      (define rotation (list-ref rotations rotation-index))
      (ormap (lambda (i)
               (ormap (lambda (j)
                        (let* ([cell (vector-ref (list-ref rotation i) j)])
                          (and (block? cell)
                               (or (< (+ x j) 0)
                                   (>= (+ x j) BOARD-WIDTH)
                                   (< (+ y i) 0)
                                   (>= (+ y i) BOARD-HEIGHT)
                                   (block? (vector-ref (list-ref fallen-blocks (+ y i)) (+ x j))))))) (stream->list (in-range 4)))) (stream->list (in-range 4))))

    (define/public (collision? fallen-blocks new-x new-y)
      (let ([new-rotations (list-ref rotations rotation-index)])
        (ormap (lambda (i)
                 (ormap (lambda (j)
                          (let* ([cell (vector-ref (list-ref new-rotations i) j)]
                                 [board-x (+ new-x j)]
                                 [board-y (+ new-y i)])
                            (and (block? cell)
                                 (block? (vector-ref (list-ref fallen-blocks board-y) board-x))))) (sequence->list (in-range 4)))) (sequence->list (in-range 4)))))

    (define/public (blocks)
      (list-ref rotations rotation-index))))

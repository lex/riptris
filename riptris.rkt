#lang racket/gui

(require "settings.rkt" "colors.rkt" "riptrominos.rkt" "drawing.rkt")

;; Game state variables
(define score 0)
(define level 1)
(define lines-cleared 0)
(define game-over? #f)
(define paused? #f)

;; Create empty board instead of test data
(define (make-empty-board)
  (build-list BOARD-HEIGHT (lambda (_) (make-vector BOARD-WIDTH 0))))

(define frame (new frame%
                   [label "riptris"]
                   [width WINDOW-WIDTH]
                   [height WINDOW-HEIGHT]))

;; Choose random riptromino
(define (get-random-riptromino)
  (define riptrominos (list t-riptromino i-riptromino o-riptromino
                           l-riptromino j-riptromino s-riptromino z-riptromino))
  ((list-ref riptrominos (random (length riptrominos)))))

(define falling-riptromino (get-random-riptromino))
(define fallen-blocks (make-empty-board))
(define next-riptromino (get-random-riptromino))

;; Function to check if line is complete
(define (line-complete? line)
  (for/and ([cell (in-vector line)])
    (block? cell)))

;; Function to clear complete lines
(define (clear-complete-lines!)
  (define complete-lines 0)

  ;; Count and remove complete lines
  (for ([i (in-range (sub1 BOARD-HEIGHT) -1 -1)])
    (when (line-complete? (list-ref fallen-blocks i))
      (set! complete-lines (add1 complete-lines))
      ;; Shift all lines above down
      (for ([j (in-range i 0 -1)])
        (set! fallen-blocks (list-set fallen-blocks j
                                     (list-ref fallen-blocks (sub1 j)))))
      ;; Add empty line at top
      (set! fallen-blocks (list-set fallen-blocks 0 (make-vector BOARD-WIDTH 0)))))

  ;; Update score based on number of lines cleared at once
  (when (> complete-lines 0)
    (set! lines-cleared (+ lines-cleared complete-lines))
    (set! score (+ score (* complete-lines complete-lines 100 level)))

    ;; Level up every 10 lines
    (when (>= (quotient lines-cleared 10) level)
      (set! level (add1 level)))))

;; Function to lock current piece and get next piece
(define (lock-piece!)
  (define blocks (send falling-riptromino blocks))
  (define x-offset (send falling-riptromino get-x))
  (define y-offset (send falling-riptromino get-y))

  ;; Add falling piece to fallen blocks
  (for ([y (in-range 0 (length blocks))])
    (define row (list-ref blocks y))
    (for ([x (in-range 0 (vector-length row))])
      (define block (vector-ref row x))
      (when (block? block)
        (define board-x (+ x x-offset))
        (define board-y (+ y y-offset))
        (when (and (>= board-y 0) (< board-y BOARD-HEIGHT))
          (vector-set! (list-ref fallen-blocks board-y) board-x block)))))

  ;; Clear any complete lines
  (clear-complete-lines!)

  ;; Get next piece
  (set! falling-riptromino next-riptromino)
  (set! next-riptromino (get-random-riptromino))

  ;; Check for game over - collision at starting position
  (when (send falling-riptromino collision? fallen-blocks
              (send falling-riptromino get-x)
              (send falling-riptromino get-y))
    (set! game-over? #t)))

;; Game tick function - called by timer
(define (game-tick)
  (unless (or game-over? paused?)
    (if (or (send falling-riptromino out-of-bounds? fallen-blocks
                  (send falling-riptromino get-x)
                  (+ (send falling-riptromino get-y) 1))
            (send falling-riptromino collision? fallen-blocks
                  (send falling-riptromino get-x)
                  (+ (send falling-riptromino get-y) 1)))
        (lock-piece!)
        (send falling-riptromino tick fallen-blocks))
    (send canvas refresh)))

;; Timer for automatic falling
(define timer (new timer%
                  [notify-callback game-tick]))

(define canvas (new
  (class canvas%
    (define/override (on-char event)
      (define key (send event get-key-code))
      (unless (or game-over? paused?)
        (cond
          [(equal? key 'left) (send falling-riptromino move-left fallen-blocks)]
          [(equal? key 'right) (send falling-riptromino move-right fallen-blocks)]
          [(equal? key 'up) (send falling-riptromino rotate fallen-blocks)]
          [(equal? key 'down) (send falling-riptromino move-down fallen-blocks)]
          [(equal? key #\space)
           ;; Hard drop - move piece all the way down
           (let loop ()
             (unless (or (send falling-riptromino out-of-bounds? fallen-blocks
                              (send falling-riptromino get-x)
                              (+ (send falling-riptromino get-y) 1))
                        (send falling-riptromino collision? fallen-blocks
                              (send falling-riptromino get-x)
                              (+ (send falling-riptromino get-y) 1)))
               (send falling-riptromino move-down fallen-blocks)
               (loop)))
           (lock-piece!)]))

      ;; Game control keys
      (cond
        [(equal? key #\p) (set! paused? (not paused?))]
        [(equal? key #\r)
         ;; Reset game
         (set! score 0)
         (set! level 1)
         (set! lines-cleared 0)
         (set! game-over? #f)
         (set! paused? #f)
         (set! fallen-blocks (make-empty-board))
         (set! falling-riptromino (get-random-riptromino))
         (set! next-riptromino (get-random-riptromino))]
        [(equal? key #\q) (send frame show #f)])

      (send this refresh))
    (super-new))
  [parent frame]
  [paint-callback
   (lambda (canvas dc)
     (send canvas set-canvas-background COLOR-BACKGROUND)
     (send dc set-scale 2 2)

     ;; Draw game area
     (draw-game dc fallen-blocks falling-riptromino)

     ;; Draw score and info
     (send dc set-font (make-font #:size 12 #:family 'modern))
     ;; Use a brighter color for better visibility
     (send dc set-text-foreground (make-object color% 255 255 255))

     ;; Fix: Account for scaling in text positioning
     ;; And use a simpler text rendering approach
     (send dc draw-text (string-append "Score: " (number->string score)) 125 10)
     (send dc draw-text (string-append "Level: " (number->string level)) 125 20)
     (send dc draw-text (string-append "Lines: " (number->string lines-cleared)) 125 30)

     ;; Use same approach for next piece text
     (send dc draw-text "Next:" 125 50)

     (define next-blocks (send next-riptromino blocks))
     (for ([y (in-range (length next-blocks))])
       (define row (list-ref next-blocks y))
       (for ([x (in-range (vector-length row))])
         (when (block? (vector-ref row x))
           (draw-block dc (+ 260 (* x BLOCK-WIDTH)) (+ 120 (* y BLOCK-HEIGHT))
                      (block-color (vector-ref row x))))))

     ;; Draw game status if needed
     (when game-over?
       (send dc draw-text "GAME OVER" 250 200)
       (send dc draw-text "Press 'r' to restart" 250 220))

     (when paused?
       (send dc draw-text "PAUSED" 250 200)
       (send dc draw-text "Press 'p' to resume" 250 220)))]))

;; Start the game
(send timer start (- 1000 (* (sub1 level) 50)))
(send frame show #t)

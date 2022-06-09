  (progn
      (let ((map (if (boundp 'input-decode-map)
                     input-decode-map
		  function-key-map)))
	;(define-key map "\e[1;C1"  (kbd "C-1"))
	;(define-key map "\e[1;CT"  (kbd "C-<tab>"))
	;; (define-key map "\e[1;SU"  (kbd "s-u"))
	;; (define-key map "\e[1;SX"  (kbd "s-x"))
	;; (define-key map "\e[1;9C" (kbd "M-<right>"))
	;; (define-key map "\e[1;9D" (kbd "M-<left>"))
	;; (define-key map "\e[1;C/" (kbd "C-/"))
	(define-key map "\e[1;C`" (kbd "C-`"))
        (define-key map "\e[1;SP"  (kbd "s-p"))

        ))

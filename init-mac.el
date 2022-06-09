(use-package clipetty
  :ensure t
  :hook (after-init . global-clipetty-mode)
  :bind (("s-c" . clipetty-kill-ring-save))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(if (eq system-type 'darwin)
    (progn
      (let ((map (if (boundp 'input-decode-map)
                     input-decode-map
		   function-key-map)))
	(define-key map "\e[1;C1"  (kbd "C-1"))
	(define-key map "\e[1;CT"  (kbd "C-<tab>"))
	(define-key map "\e[1;SU"  (kbd "s-u"))
	(define-key map "\e[1;SC"  (kbd "s-c"))
	(define-key map "\e[1;SX"  (kbd "s-x"))
	(define-key map "\e[1;9C" (kbd "M-<right>"))
	(define-key map "\e[1;9D" (kbd "M-<left>"))
	(define-key map "\e[1;C/" (kbd "C-/"))
	(define-key map "\e[1;C`" (kbd "C-`"))
	(define-key map "\e[1;SB" (kbd "s-b"))
        (define-key map "\e[1;Sa"  (kbd "s-a"))
        (define-key map "\e[1;S/"  (kbd "s-/"))
        (define-key map "\e[1;Sz"  (kbd "s-z"))
	))
;;)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; the following designed for paste stuff into emacs term and ansi-term
(defun new-xterm-paste(event)
  (interactive "e")
  (unless (eq (car-safe event) 'xterm-paste)
    (error "xterm-paste must be found to xterm-paste event"))
  (let* ((pasted-text (nth 1 event)))
    (term-send-raw-string pasted-text)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;with macbook, i prefer CMD+c/v to copy/paste both in emacs
;;;;;;;;;;;and system, but CMD+mouse also highlight, after use mouse
;;;;;;;;;;;to select a region, CMD could be pressed before "mark set",
;;;;;;;;;;;so highlight action will be used instead of copy
(global-unset-key (kbd "<M-drag-mouse-1>"))   ; was mouse-set-secondary
(global-unset-key (kbd "<M-down-mouse-1>"))   ; was mouse-drag-secondary
(global-unset-key (kbd "<M-mouse-1>"))	  ; was mouse-start-secondary
(global-unset-key (kbd "<M-mouse-2>"))	  ; was mouse-yank-secondary
(global-unset-key (kbd "<M-mouse-3>"))	  ; was mouse-secondary-save-then-kill

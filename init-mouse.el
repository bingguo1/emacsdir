(unless window-system
  (require 'mouse) ;; needed for iterm2 compatibility
  (setq mouse-sel-mode t)
  (setq x-select-enable-clipboard t)
  ;;  (setq x-select-enable-primary nil)
  ;;  (setq mouse-drag-copy-region nil)
  (xterm-mouse-mode t)
  (if (eq system-type 'darwin)
       (progn
	 (global-set-key [mouse-4] '(lambda ()
				      (interactive)
				      (scroll-down 1)))
	 (global-set-key [mouse-5] '(lambda ()
				      (interactive)
				      (scroll-up 1)))
         ))

 			 


  
  (defun track-mouse (e)))



(defun mouse-start-end (start end mode)
  "Return a list of region bounds based on START and END according to MODE.
If MODE is 0 then set point to (min START END), mark to (max START END).
If MODE is 1 then set point to start of word at (min START END),
mark to end of word at (max START END).
If MODE is 2 then do the same for lines."
  (if (> start end)
      (let ((temp start))
        (setq start end
              end temp)))
  (setq mode (mod mode 3))
  (cond ((= mode 0)
	 (list start end))
        ((and (= mode 1)
              (= start end)
	      (char-after start)
              (= (char-syntax (char-after start)) ?\())
         (if (/= (syntax-class (syntax-after start)) 4) ; raw syntax code for ?\(
             ;; This happens in CC Mode when unbalanced parens in CPP
             ;; constructs are given punctuation syntax with
             ;; syntax-table text properties.  (2016-02-21).
             (signal 'scan-error (list "Containing expression ends prematurely"
                                       start start))
           (list start
                 (save-excursion
                   (goto-char start)
                   (forward-sexp 1)
                   (point)))))
        ((and (= mode 1)
              (= start end)
	      (char-after start)
              (= (char-syntax (char-after start)) ?\)))
         (if (/= (syntax-class (syntax-after start)) 5) ; raw syntax code for ?\)
             ;; See above comment about CC Mode.
             (signal 'scan-error (list "Unbalanced parentheses" start start))
           (list (save-excursion
                   (goto-char (1+ start))
                   (backward-sexp 1)
                   (point))
                 (1+ start))))
	((and (= mode 1)
              (= start end)
	      (char-after start)
              (= (char-syntax (char-after start)) ?\"))
	 (let ((open (or (eq start (point-min))
			 (save-excursion
			   (goto-char (- start 1))
			   (looking-at "\\s(\\|\\s \\|\\s>")))))
	   (if open
	       (list start
		     (save-excursion
		       (condition-case nil
			   (progn
			     (goto-char start)
			     (forward-sexp 1)
			     (point))
			 (error end))))
	     (list (save-excursion
		     (condition-case nil
			 (progn
			   (goto-char (1+ start))
			   (backward-sexp 1)
			   (point))
		       (error end)))
		   (1+ start)))))
        ((= mode 1)
	 (list (save-excursion
		 (goto-char start)
		 (skip-chars-backward "-A-Za-z0-9_.~/+*")
		 (point))
	       (save-excursion
		 (goto-char end)
		 (skip-chars-forward "-A-Za-z0-9_.~/+*") 
		 (point))))
        ((= mode 2)
	 (list (save-excursion
		 (goto-char start)
		 (line-beginning-position 1))
	       (save-excursion
		 (goto-char end)
		 (forward-line 1)
		 (point))))))

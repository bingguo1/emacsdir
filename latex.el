;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;latex latex auctex ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(defun LaTeX-save-and-compile (arg)
  "Once you click save, it will run tex command run all."  
  (interactive "P")
  (save-buffer)
  (TeX-command-run-all arg)
  )

;; (setenv "PATH" (concat "/Library/TeX/texbin:""/usr/local/opt:"
;;                      (getenv "PATH")))
;; (add-to-list 'exec-path "/Library/TeX/texbin")
;; (add-to-list 'exec-path "/usr/local/opt")
;;(setq-default TeX-master nil)
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
(add-hook 'LaTeX-mode-hook
	  (lambda ()

	    (yas-minor-mode)
	    (setq company-minimum-prefix-length 4)
	    (flyspell-mode)

	    (setq TeX-auto-save t)
	    (setq TeX-parse-self t)
	    ;;(setq-default TeX-master nil) ;; enable only when working with multiple file system
	    (setq TeX-PDF-mode t)
	    ;;	    (latex-preview-pane-enable)
	    (setq doc-view-continuous t) ;;;; so the pdf on my preview-pane can scroll continuously	    
	    ;;	    (pdf-tools-install)
	    (pdf-loader-install)
	    (setq TeX-view-program-selection '((output-pdf "pdf-tools"))
		  TeX-source-correlate-start-server t)
	    (setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view")))
	    ;;;;;;;; when you are pressing mouse, it's down-mouse, when finish it, it's mouse-1, so down-mouse work before mouse
	    (define-key LaTeX-mode-map (kbd "C-<mouse-1>") 'pdf-sync-forward-search)
	    (define-key LaTeX-mode-map (kbd "C-<down-mouse-1>") 'mouse-set-point)
	    (define-key LaTeX-mode-map (kbd "C-x C-s") 'LaTeX-save-and-compile)
	    (set (make-variable-buffer-local 'TeX-electric-math)
		 (cons "$" "$"))

	    (add-to-list 'TeX-command-list
			 '("latexmk" "latexmk -pdflatex='pdflatex -file-line-error -synctex=1' -pdf %s"
			   TeX-run-command nil t :help "Run latexmk") t)
	    (LaTeX-math-mode)
	    (setq LaTeX-electric-left-right-brace t)
	    (setq LaTeX-command-style  '(("" "%(PDF)%(latex) -shell-escape --synctex=1 %(file-line-error) %(extraopts) %S%(PDFout)")))
	    (setq TeX-source-correlate-method 'synctex)
	    (setq TeX-source-correlate-mode t)
	    (setq TeX-source-correlate-start-server t)
	    (define-key LaTeX-mode-map [C-i] 'latex-math-preview-insert-symbol)
	    (define-key LaTeX-mode-map (kbd "C-e") 'latex-math-preview-expression)
	    (define-key LaTeX-mode-map (kbd "C-t") 'format-to-latex-table)

	    ;;;;;;;;;;;;;;;;;;;;;;; latex-math-preview
	    (autoload 'latex-math-preview-expression "latex-math-preview" nil t)
	    (autoload 'latex-math-preview-insert-symbol "latex-math-preview" nil t)
	    (autoload 'latex-math-preview-save-image-file "latex-math-preview" nil t)
	    (autoload 'latex-math-preview-beamer-frame "latex-math-preview" nil t)
	    (setq latex-math-preview-image-foreground-color "#ccffcc")	    
))
;;(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)

;;;;;;;;;;;;;;;;;;;;;; latex format table

(defun format-to-latex-table (top bottom)                                                                          
  "format a simple table to latex format."                                                                          
  (interactive "r")

  (let ((end bottom) 
        char next-line)
    (goto-char top)
    (deactivate-mark)
    (if (not (bolp))
        (forward-line 1))
    (setq next-line (point))
    (while (< next-line bottom)
      (forward-char)
      (while (not (eolp))
        (while (and (not (string= " " (string (char-after)))) (not (string= "\t" (string (char-after)))) (not (eolp)))
	  (if (string= "%" (string (char-after)))
	      (insert "\\"))
          (forward-char)
          )          
        (if (not (eolp))
	    (progn 
              (insert "&")
	      (forward-word))	      
	  )
        )          
      (insert "\\\\")
      (forward-line)
      (setq next-line (point))
      )))

;; (load-file "~/.emacs.d/pdf-continuous-scroll-mode.el")
;; (with-eval-after-load 'pdf-view
;;   (require 'pdf-continuous-scroll-mode))
;; (add-hook 'pdf-view-mode-hook 'pdf-continuous-scroll-mode)



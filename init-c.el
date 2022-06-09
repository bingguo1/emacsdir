
(setq compilation-skip-threshold 2)
(setq-default c-basic-offset 4)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.C\\'" . c++-mode))

(add-hook 'c++-mode-hook
          (lambda ()
	    ;;            (hs-minor-mode t)
	    (abbrev-mode -1)
            (define-key c-mode-base-map (kbd "C-w") 'hs-toggle-hiding)
;;            (define-key c-mode-base-map (kbd "C-c s") 'hs-show-all)
;;            (define-key c-mode-base-map (kbd "C-c h") 'hs-hide-all)
;;	    (define-key c-mode-base-map (kbd "S-<mouse-1>") 'ggtags-find-tag-mouse)
            ))

(use-package cmake-ide
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq use-lsp nil)
(unless use-lsp
  (defun my-c++mode-company-hook ()
    (setq company-backends
          '((
	     company-irony-c-headers
;	   company-irony
;	   company-etags
;	   company-dabbrev-code
	   company-clang
;	   company-gtags
;	   company-files
	   company-capf
	   ))))
;;;;;irony  
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  (add-hook 'irony-mode-hook #'irony-eldoc)
  
  (add-hook 'c++-mode-hook 'my-c++mode-company-hook)  
  
  ;;(add-to-list 'company-backends 'company-irony-c-headers)
;;;;;;;cmake-ide
  (cmake-ide-setup)
  (global-set-key (kbd "C-c c c") 'cmake-ide-compile)

  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; gdb  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq gdb-many-windows t)
(eval-after-load 'gdb-mi
  '(defun gdb-setup-windows ()
  "Layout the window pattern for option `gdb-many-windows'."
  (gdb-get-buffer-create 'gdb-breakpoints-buffer)
  (set-window-dedicated-p (selected-window) nil)
  (switch-to-buffer gud-comint-buffer)
   (delete-other-windows)
   (let ((win0 (selected-window))
        (win1 (split-window nil (* ( / (window-height) 3) 2)))
        (win2 (split-window-right)))
      (select-window win2)
      (set-window-buffer
       win2
       (if gud-last-last-frame
           (gud-find-file (car gud-last-last-frame))
	 (if gdb-main-file
             (gud-find-file gdb-main-file)
           ;; Put buffer list in window if we
           ;; can't find a source file.
           (list-buffers-noselect))))
      (setq gdb-source-window (selected-window))
      (select-window win1)
      (gdb-set-window-buffer
       (gdb-get-buffer-create 'gdb-inferior-io) nil win1)
      (let ((win3 (split-window-right)))
	(gdb-set-window-buffer (if gdb-show-threads-by-default
                                   (gdb-threads-buffer-name)
				 (gdb-breakpoints-buffer-name))
			       nil win3))
      (select-window win0))))


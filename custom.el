

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;(add-to-list 'load-path "~/.emacs.d/themes/")
;(require 'moe-theme)

(powerline-default-theme)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(setq moe-theme-highlight-buffer-id t)
    ;; Resize titles (optional).
;;(setq moe-theme-resize-markdown-title '(1.5 1.4 1.3 1.2 1.0 1.0))
;(setq moe-theme-resize-org-title '(1.5 1.4 1.3 1.2 1.1 1.0 1.0 1.0 1.0))
;(setq moe-theme-resize-rst-title '(1.5 1.4 1.3 1.2 1.1 1.0))
;(moe-theme-set-color 'cyan)
;(load-theme 'moe-dark t)


;;(load-theme 'dracula t)
;;(load-theme 'spacemacs-dark t)
;;(load-theme 'ample t t)
;;(load-theme 'ample-flat t t)
;;(load-theme 'ample-light t t)
;; choose one to enable
;;(enable-theme 'ample)
;; (enable-theme 'ample-flat)
;; (enable-theme 'ample-light)

(load-theme 'monokai t)
;;;;;;;;; ESHELL prompt
(defun with-face (str &rest face-plist)
  (propertize str 'face face-plist))

(defun shk-eshell-prompt ()
  (let ((header-bg "#fff"))
    (concat
     (with-face (format-time-string "(%Y-%m-%d %H:%M)" (current-time)) :foreground "#ff8000")
     (with-face (concat (eshell/pwd) "") :foreground "#00b3b3")
     "$ ")))
(setq eshell-prompt-function 'shk-eshell-prompt)
(setq eshell-highlight-prompt nil)



;;(load-theme 'dracula t)
;(load-theme 'panda t)
;;;;(load-theme 'blackboard t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
 '(package-selected-packages
   '(company tabbar sr-speedbar spacemacs-theme simpleclip sane-term powerline panda-theme origami neotree minimap markdown-preview-eww markdown-mode+ latex-preview-pane helm flycheck flx-ido elfeed edit-indirect dracula-theme dashboard ctags-update counsel blackboard-theme auto-complete auctex))
 '(sr-speedbar-auto-refresh t))
;;; '(term-char-mode-buffer-read-only nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-highlight-prompt ((t (:foreground "magenta"))))
 '(isearch ((t (:inherit region :background "brightyellow" :foreground "#1B1E1C"))))
 '(lazy-highlight ((t (:inherit highlight :background "#FF99999")))))

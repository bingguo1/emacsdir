

(require 'package)

;;;;;when double clicking with mouse, normally i want to select a long word which contain underscore and dot, to do this, the definition of word has to be changed.
(modify-syntax-entry ?_ "w" (standard-syntax-table))
(modify-syntax-entry ?. "w" (standard-syntax-table))
(modify-syntax-entry ?/ "w" (standard-syntax-table))

(add-hook 'prog-mode-hook 'linum-mode)

(global-set-key (kbd "C-x r") 'find-file-read-only)
;; If you want to use latest version
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; If you want to use last tagged version
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)



;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(add-to-list 'load-path "~/.emacs.d/lisp/")


(defun delete-line (&optional arg)
  "Delete text from current position to end of line char.  This command does not push text to `kill-ring'.  with or without ARG"
  (interactive "P")
  (delete-region (point)
   (progn
     (if arg
         (forward-visible-line (prefix-numeric-value arg))
       (if (eobp)
           (signal 'end-of-buffer nil))
       (let ((end
              (save-excursion
                (end-of-visible-line) (point))))
         (if (or (save-excursion
                   ;; If trailing whitespace is visible,
                   ;; don't treat it as nothing.
                   (unless show-trailing-whitespace
                     (skip-chars-forward " \t" end))
                   (= (point) end))
                 (and kill-whole-line (bolp)))
             (forward-visible-line 1)
           (goto-char end))))
     (point))))
(global-set-key  (kbd "C-k") 'delete-line)





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



(require 'awesome-tab)
(awesome-tab-mode t)
(when window-system
  (setq awesome-tab-active-bar-height 9)
  (setq awesome-tab-height 100))
(defun my-tabbar-buffer-groups ()
  (list
   (cond
    ((derived-mode-p 'dired-mode)
     "user")
    ((derived-mode-p 'eshell-mode)
     "user")
    ((derived-mode-p 'shell-mode)
     "user")
    ((derived-mode-p 'term-mode)
     "user")
    ((derived-mode-p 'diff-mode)
     "user")
    ((derived-mode-p 'compilation-mode)
     "user")
    ((or (string-equal "*" (substring (buffer-name) 0 1))
         (memq major-mode '(magit-process-mode
                            magit-status-mode
                            magit-diff-mode
                            magit-log-mode
                            magit-file-mode
                            magit-blob-mode
                            magit-blame-mode
                            )))
     "Emacs")
    (t
     "user"))))
(setq awesome-tab-buffer-groups-function 'my-tabbar-buffer-groups)
(global-set-key (kbd "C-<left>") 'awesome-tab-backward-tab)
(global-set-key (kbd "C-<right>") 'awesome-tab-forward-tab)
(global-set-key (kbd "C-<down>") 'awesome-tab-forward-group)
(global-set-key (kbd "C-<up>") 'awesome-tab-backward-group)
(global-set-key (kbd "C-q") 'kill-this-buffer)
(global-set-key (kbd "C-S-<left>") 'awesome-tab-move-current-tab-to-left)
(global-set-key (kbd "C-S-<right>") 'awesome-tab-move-current-tab-to-right)



(unless window-system (menu-bar-mode -1))
(when window-system
  (set-face-attribute 'default nil :font "Monaco-10" )
;  (setq-default line-spacing 0.1)
  )
(toggle-scroll-bar -1)
;;(ac-config-default)
(setq compilation-skip-threshold 2)
(setq-default c-basic-offset 4)



(defun shell-other-window ()
  "Open a `shell' in a new window."
  (interactive)
  (let ((buf (shell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))
(defun unique-shell ()
  (interactive)
  (call-interactively 'shell)
  (rename-uniquely))

;;(global-set-key (kbd "C-d") 'unique-shell)
(defun unique-term ()
  (interactive)
  (call-interactively 'term)
  (rename-uniquely))

(setq shell-file-name "/bin/bash")
;;;;(setq explicit-shell-file-name "/bin/bash") ;;; <---- this doesn't help on "stop promping /bin/bash when open a term"
(global-set-key (kbd "M-t") 'unique-term)

(global-set-key (kbd "S-<left>") 'windmove-left)
(global-set-key (kbd "S-<right>") 'windmove-right)
(global-set-key (kbd "S-<up>") 'windmove-up)
(global-set-key (kbd "S-<down>") 'windmove-down)
(global-set-key (kbd "<end>") 'move-end-of-line)
(global-set-key (kbd "<home>") 'move-beginning-of-line)

;;;;;;; in shell mode, add short cut to use up/down arrow to find previous history commands
(add-hook 'comint-mode-hook
      (lambda ()
        (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
        (define-key comint-mode-map (kbd "<down>") 'comint-next-input)
        (define-key comint-mode-map (kbd "C-u") 'kill-whole-line)
	(define-key comint-mode-map (kbd "C-<up>") nil)
        (define-key comint-mode-map (kbd "C-<down>") nil)
	))

(defun discard-command ()
  "discard current command in eshell."
  (interactive)
  (eshell-bol)
  (kill-line)
  )

(add-hook 'eshell-mode-hook
          (lambda ()
            (define-key eshell-mode-map (kbd "C-u") 'discard-command)
            (define-key eshell-mode-map (kbd "C-<up>") nil)
            (define-key eshell-mode-map (kbd "C-<down>") nil)
            ))


(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(require 'org)





;;;;;;;;;;;;;;;  ;;;;;;;;;;;;; flx-ido  ;;;;;;;;;;;;;;;  smex  ;;;;;;;;;;;;;
(defun ido-recentf-open ()
  "Use `ido-completing-read' to find a recent file."
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))
(defun use-flx-recentf-smex()
  (require 'flx-ido)
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  ;; disable ido faces to see flx highlights.
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil)
  (setq ido-use-filename-at-point 'guess)
  
  (require 'recentf)
  (recentf-mode 1)
  (setq recentf-max-saved-items 50)
  (global-set-key (kbd "C-x C-r") 'ido-recentf-open)
  (require 'smex) ; Not needed if you use package.el
  (smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                    ; when Smex is auto-initialized on its first run.
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; helm
(defun use-helm()
  (add-to-list 'load-path "~/.emacs.d/download/helm/")
  (add-to-list 'load-path "~/.emacs.d/elpa/emacs-async/")
  (require 'helm-config)
;  (helm-mode 1)  ;;;; <-- donot turn on helm mode everywhere, in ESHELL, helm will mess up the auto-completion
  (global-set-key (kbd "M-x") 'helm-M-x)
  (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x C-r") 'helm-recentf)
; keep a list of recently opened files                                                                      
  (recentf-mode 1)
  (setq recentf-max-saved-items 100)
  (setq-default recent-save-file "~/.emacs.d/recentf"))

;;(use-flx-recentf-smex)
(use-helm)



;;(global-unset-key (kbd "C-x C-c"))
;;(global-set-key (kbd "C-x C-q") 'save-buffers-kill-terminal)


(setq elfeed-feeds
      '("http://feeds.bbci.co.uk/news/world/rss.xml"
	"https://www.buzzfeed.com/world.xml"
	"https://www.vreadtech.com/rss_test.php?uin=obyEs1ftzAphGTsPZr0kNTZkVS8w&key=b9e6709cac6efd338f3808efbddc5fbe"
	"https://www.vreadtech.com/rss_test.php?uin=obyEs1ftzAphGTsPZr0kNTZkVS8w&key=50f93b198b9e41601df2a044d25368ac"
	"https://www.reddit.com/r/worldnews/.rss"
	"http://news.ifeng.com/rss/index.xml"
	))


;; (add-hook 'c++-mode-hook
;;           (lambda ()
;; 	    (hs-minor-mode)
;; 	    (define-key c-mode-base-map (kbd "C-a") 'hs-toggle-hiding)
;; 	    (define-key c-mode-base-map (kbd "C-p") 'hs-show-all)
;; 	    (define-key c-mode-base-map (kbd "C-o") 'hs-hide-all)
;;             ))

(global-set-key (kbd "M-w") 'kill-region)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)


(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.C\\'" . c++-mode))

(add-hook 'c++-mode-hook
          (lambda ()
;;            (hs-minor-mode t)
            (define-key c-mode-base-map (kbd "C-a") 'hs-toggle-hiding)
            (define-key c-mode-base-map (kbd "C-p") 'hs-show-all)
            (define-key c-mode-base-map (kbd "C-o") 'hs-hide-all)
            ))



;;;; term-raw-map is for term char mode, term-mode-map is for line mode of term
(defun term-send-Mright () (interactive) (term-send-raw-string "\ef"))
(defun term-send-Mleft  () (interactive) (term-send-raw-string "\eb"))
(add-hook 'term-load-hook
	  (lambda ()
;;;	    (setq term-char-mode-buffer-read-only nil)  ;;; no need
	    (setq term-char-mode-point-at-process-mark nil) ;;; this will make backward-word and forward-word works!!!!
	    (define-key term-raw-map (kbd "C-<left>") 'awesome-tab-backward-tab)
	    (define-key term-raw-map (kbd "C-<right>") 'awesome-tab-forward-tab)
	    (define-key term-raw-map (kbd "C-<down>") 'awesome-tab-forward-group)
	    (define-key term-raw-map (kbd "C-<up>") 'awesome-tab-backward-group)
	    (define-key term-raw-map (kbd "C-q") 'kill-this-buffer)
	    (define-key term-raw-map (kbd "C-x") nil)
	    (define-key term-raw-map (kbd "<ESC>") nil)
	    (define-key term-raw-map (kbd "C-c") nil)
	    (define-key term-raw-map (kbd "C-z") nil)
	    (define-key term-raw-map (kbd "C-h") nil)

	    
    
	    (define-key term-raw-map (kbd "C-s") isearch-forward)
	    ;;      (define-key term-raw-map (kbd "C-r") isearch-backward)  ;; C-r is already predefined, if you really want to change it, then set it nil first
	    (define-key term-raw-map (kbd "C-x C-f") 'helm-find-files)
	    (define-key term-raw-map (kbd "C-x C-r") 'helm-recentf)
	    (define-key term-raw-map (kbd "C-c C-c") 'term-interrupt-subjob)
	    (define-key term-raw-map (kbd "C-c C-z") 'term-kill-subjob)
	    
	    (define-key term-raw-map (kbd "M-x") 'helm-M-x)
	    (define-key term-raw-map (kbd "<xterm-paste>") 'nil) ; ;;;;;; need this, or it will kill this SSH_session
	    (define-key term-raw-map (kbd "M-c") 'kill-ring-save)  
	    (define-key term-raw-map (kbd "M-v") 'term-paste)

	    (define-key term-raw-map (kbd "M-f")    'term-send-Mright)  ;;;;; use M-<left/right>  does not work , i guess it's bound to M-f/b
            (define-key term-raw-map (kbd "M-b")     'term-send-Mleft)
	    
    ))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn
  (let ((map (if (boundp 'input-decode-map)
                 input-decode-map
               function-key-map)))
    (define-key map "\e[1;P1"  (kbd "C-1"))
    (define-key map "\e[1;PT"  (kbd "C-<tab>"))
    (define-key map "\e[1;SU"  (kbd "s-u"))
    ))

(global-set-key (kbd "s-u") 'revert-buffer)

(require 'sr-speedbar)
;;(custom-set-variables '(sr-speedbar-right-side nil) '(sr-speedbar-skip-other-window-p t) '(sr-speedbar-max-width 20) '(sr-speedbar-width-x 10))
(custom-set-variables '(sr-speedbar-auto-refresh t))
(setq speedbar-tag-hierarchy-method nil)
(eval-after-load "speedbar" '(speedbar-add-supported-extension ".txt"))

(global-set-key (kbd "C-f") 'sr-speedbar-refresh-toggle)
 (defun sb-toggle-expansion-curren-file ()
   "Expand current file in speedbar buffer"  
   (interactive)                                                                                                                               
   (setq current-file (buffer-file-name))
   (sr-speedbar-refresh)
;;   (switch-to-buffer-other-frame "*SPEEDBAR*")  ;;; this link will split the other buffer to two 
   (speedbar-find-selected-file current-file)
   (speedbar-toggle-line-expansion))
(global-set-key (kbd "C-1") 'sb-toggle-expansion-curren-file)
(global-set-key (kbd "C-<tab>") 'sr-speedbar-toggle)


;;;;;;;;;;; yas
(require 'yasnippet)
(yas-reload-all)
(add-hook 'c++-mode-hook #'yas-minor-mode)


;;;;;;;;;;ggtags
(global-set-key (kbd "S-<mouse-1>") 'ggtags-find-tag-mouse)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;company 
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0)
;; (setq company-backends
;;       '((company-dabbrev-code
;; 	 company-clang
;; 	 company-gtags
;;          company-capf
;; 	 company-keywords
;;          )
;;         (company-abbrev company-dabbrev)
;;         ))
(defun my-c++mode-company-hook ()
  ;;  (ycmd-mode t)
  (setq company-auto-complete t)
  (setq company-minimum-prefix-length 3)
  (setq company-backends
        '((
	   company-irony
;	   company-etags
;	   company-dabbrev-code
;	   company-clang
;	   company-gtags
	   company-files
;	   company-capf
	   ))))
(global-set-key (kbd "C-c f") 'company-files)
(add-hook 'c++-mode-hook 'my-c++mode-company-hook)

;;;;;irony
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


;;(add-to-list 'company-backends 'company-irony-c-headers)


;;;;;;;cmake-ide
(cmake-ide-setup)
(global-set-key (kbd "C-c m") 'cmake-ide-compile)

;;;;;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(global-set-key (kbd "C-c l") 'flycheck-list-errors)
(global-set-key (kbd "C-c <up>") 'flycheck-previous-error)
(global-set-key (kbd "C-c <down>") 'flycheck-next-error)




;;;;;;;;;;;;;;;;;; dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)



;;;;;;;;;;;latex latex auctex ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
;; (setenv "PATH" (concat "/Library/TeX/texbin:""/usr/local/opt:"
;;                      (getenv "PATH")))
;; (add-to-list 'exec-path "/Library/TeX/texbin")
;; (add-to-list 'exec-path "/usr/local/opt")
(setq TeX-auto-save t)
(setq TeX-parse-self t)
;;(setq-default TeX-master nil) ;; enable only when working with multiple file system
(setq TeX-PDF-mode t)
(latex-preview-pane-enable)
(setq doc-view-continuous t) ;;;; so the pdf on my preview-pane can scroll continuously


(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)



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




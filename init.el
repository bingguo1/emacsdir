
(setq gc-cons-threshold (* 50 1000 1000))

(eval-when-compile
  (require 'use-package))
;;(require 'package)

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;;(require 'treemacs)
;;(treemacs-tag-follow-mode)
;;(global-set-key (kbd "C-<tab>") 'treemacs)
(defun use-lsp()
  ;;  (setq lsp-clients-clangd-executable "/dune/app/users/mylab/softs/clangd/clangd_10.0.0/bin/clangd")
  (use-package lsp-mode
    :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
            (c++-mode . lsp)
            ;; if you want which-key integration
            (lsp-mode . lsp-enable-which-key-integration))
    :commands lsp
    :init
    (setq lsp-keymap-prefix "C-l")
  ))

;;(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;;(add-hook 'prog-mode-hook 'highlight-indentation-mode)
;;(setq highlight-indentation-blank-lines t)
(run-at-time nil (* 15 60) 'recentf-save-list)
;; (defun pbpaste ()
;;   (interactive)
;;   (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

;; (defun new-term-paste ()
;;   "Insert the text pasted in an XTerm bracketed paste operation."
;;   (interactive)
;;   (term-send-raw-string  (shell-command-to-string "pbpaste")))
;;;;;;;;;;; the following designed for paste stuff into emacs term and ansi-term
(defun new-xterm-paste(event)
  (interactive "e")
  (unless (eq (car-safe event) 'xterm-paste)
    (error "xterm-paste must be found to xterm-paste event"))
  (let* ((pasted-text (nth 1 event)))
    (term-send-raw-string pasted-text)))


(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

(defun my-set-margins ()  ;;;; the purpose is to show flycheck error indicatioin on left margin, at least 3 to let it appear
  "Set margins in current buffer."
  (setq left-margin-width 3)
  (setq right-margin-width 0))
(add-hook 'prog-mode-hook 'my-set-margins)

(global-clipetty-mode)
(global-set-key (kbd "s-c") 'clipetty-kill-ring-save)


(if window-system
    (define-key input-decode-map "\C-i" [C-i])) ;;;; unbound C-i from tab key ;;;; this is okay for window emacs, but iterm emacs will fail to use tab key

(global-set-key (kbd "C-/") 'comment-region)
(defun get-word-boundary ()
  "Return the boundary of the current word.
         The return value is of the form: (cons pos1 pos2).
         "
  (save-excursion
    (let (p1 p2)
      (progn
        (skip-chars-backward "-A-Za-z0-9_.~/+*") ;; here you can choose which symbols to use
        (setq p1 (point))
        (skip-chars-forward "-A-Za-z0-9_.~/+*") ;; put the same here
        (setq p2 (point)))
      (cons p1 p2)
      ))
  )
(defun select-word ()
  "Mark the url under cursor."
  (interactive)
					;  (require 'thingatpt)
  (let (bds)
    (setq bds (get-word-boundary))
    
    (set-mark (car bds))
    (goto-char (cdr bds))
    )
  )




(global-set-key [double-mouse-1] 'select-word)


;;;;;when double clicking with mouse, normally i want to select a long word which contain underscore and dot, to do this, the definition of word has to be changed.
;(modify-syntax-entry ?_ "w" (standard-syntax-table))
;(modify-syntax-entry ?. "w" (standard-syntax-table))
;(modify-syntax-entry ?/ "w" (standard-syntax-table))

(add-hook 'prog-mode-hook 'linum-mode)

(global-set-key (kbd "C-x r") 'find-file-read-only)
;; If you want to use latest version
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
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



					;(require 'awesome-tab)
					;(awesome-tab-mode t)
(use-package awesome-tab
  :config
  (awesome-tab-mode t))

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
;;(global-set-key [triple-wheel-left] 'awesome-tab-backward-tab)  ;;; in macbook pro, two fingers left/ right is this, too fast, not going to use
;;(global-set-key [triple-wheel-right] 'awesome-tab-forward-tab)


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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; org ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(with-eval-after-load 'org
  (require 'org-tempo) ;;;; enable the old way to create a block by < + key + <tab>
  (global-set-key (kbd "C-c o l") 'org-store-link)
  (global-set-key (kbd "C-c o a") 'org-agenda)
  (global-set-key (kbd "C-c o c") 'org-capture)
  (setq org-image-actual-width nil)
  
  (require 'org-download)
  ;; Drag-and-drop to `dired`
  (add-hook 'dired-mode-hook 'org-download-enable)
  (with-eval-after-load 'org
    (org-download-enable))
  
  (unless (string= (user-login-name) "mylab")
    (setq org-default-notes-file "~/doc_emacs/orgs/tasks.org")
    (setq org-agenda-files '("~/doc_emacs/orgs/agenda/"))
    )
  
  (require 'ox-latex)
  (add-to-list 'org-latex-classes
               '("beamer"
		 "\\documentclass\[presentation\]\{beamer\}"
		 ("\\section\{%s\}" . "\\section*\{%s\}")
		 ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
		 ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
  )

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
  (setq recentf-max-saved-items 200)
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
  (use-package helm
    :init
    (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
    (recentf-mode 1)
    (setq recentf-max-saved-items 200)
    (setq-default recent-save-file "~/.emacs.d/recentf")
    :config
    (require 'helm-config)
    :bind (("M-x" . helm-M-x)
	    ("C-x C-f" . helm-find-files)
	    ("C-x C-r" .  helm-recentf))
					;  (helm-mode 1)  ;;;; <-- donot turn on helm mode everywhere, in ESHELL, helm will mess up the auto-completion
   
    ))

;;(use-flx-recentf-smex)
(use-helm)



;;(global-unset-key (kbd "C-x C-c"))
;;(global-set-key (kbd "C-x C-q") 'save-buffers-kill-terminal)


;; (setq elfeed-feeds
;;       '("http://feeds.bbci.co.uk/news/world/rss.xml"
;; 	"https://www.buzzfeed.com/world.xml"
;; 	"https://www.vreadtech.com/rss_test.php?uin=obyEs1ftzAphGTsPZr0kNTZkVS8w&key=b9e6709cac6efd338f3808efbddc5fbe"
;; 	"https://www.vreadtech.com/rss_test.php?uin=obyEs1ftzAphGTsPZr0kNTZkVS8w&key=50f93b198b9e41601df2a044d25368ac"
;; 	"https://www.reddit.com/r/worldnews/.rss"
;; 	"http://news.ifeng.com/rss/index.xml"
;; 	))


;; (add-hook 'c++-mode-hook
;;           (lambda ()
;; 	    (hs-minor-mode)
;; 	    (define-key c-mode-base-map (kbd "C-a") 'hs-toggle-hiding)
;; 	    (define-key c-mode-base-map (kbd "C-p") 'hs-show-all)
;; 	    (define-key c-mode-base-map (kbd "C-o") 'hs-hide-all)
;;             ))
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "M-w") 'kill-region)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)


(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.C\\'" . c++-mode))

(add-hook 'c++-mode-hook
          (lambda ()
	    ;;            (hs-minor-mode t)
	    (abbrev-mode -1)
            (define-key c-mode-base-map (kbd "C-w") 'hs-toggle-hiding)
;;            (define-key c-mode-base-map (kbd "C-c s") 'hs-show-all)
;;            (define-key c-mode-base-map (kbd "C-c h") 'hs-hide-all)
	    (define-key c-mode-base-map (kbd "S-<mouse-1>") 'ggtags-find-tag-mouse)
            ))



;;;; term-raw-map is for term char mode, term-mode-map is for line mode of term
(defun term-send-Mright () (interactive) (term-send-raw-string "\ef"))
(defun term-send-Mleft  () (interactive) (term-send-raw-string "\eb"))
(defun my-term-send-home  () (interactive) (term-send-raw-string "\e[H"))
(defun my-term-send-end  () (interactive) (term-send-raw-string "\e[F"))
(add-hook 'term-load-hook
	  (lambda ()
	    (setq term-char-mode-buffer-read-only nil)  ;;; this have to be used, so new-xterm-paste can paste stuff into term and ansi-term
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
	    (define-key term-raw-map (kbd "<xterm-paste>") 'new-xterm-paste)
	    (define-key term-raw-map (kbd "s-c") 'clipetty-kill-ring-save)
	    (define-key term-raw-map (kbd "M-v") 'term-paste)

	    (define-key term-raw-map (kbd "M-f")    'term-send-Mright)  ;;;;; use M-<left/right>  does not work , i guess it's bound to M-f/b
            (define-key term-raw-map (kbd "M-b")     'term-send-Mleft)
	    (define-key term-raw-map (kbd "<home>")    'my-term-send-home) 
	    (define-key term-raw-map (kbd "<end>")    'my-term-send-end)
    ))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
    ))

(global-set-key (kbd "s-u") 'revert-buffer)

(require 'sr-speedbar)
;;(custom-set-variables '(sr-speedbar-right-side nil) '(sr-speedbar-skip-other-window-p t) '(sr-speedbar-max-width 20) '(sr-speedbar-width-x 10))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-auto-commit nil)
 '(flycheck-indication-mode 'left-margin)
 '(mouse-drag-and-drop-region 'modifier)
 '(mouse-drag-and-drop-region-cut-when-buffers-differ t)
 '(org-download-image-org-width 300)
 '(org-download-screenshot-method "screencapture -i %s")
 '(package-selected-packages
   '(use-package esup company-irony-c-headers treemacs lsp-mode irony-eldoc clipetty pdf-tools latex-math-preview org-download cdlatex shell-pop multiple-cursors exec-path-from-shell which-key smartparens yasnippet-snippets flycheck-irony ggtags company-irony irony yasnippet rtags cmake-ide company tabbar sr-speedbar spacemacs-theme simpleclip sane-term powerline panda-theme origami neotree minimap markdown-preview-eww markdown-mode+ latex-preview-pane helm flycheck flx-ido elfeed edit-indirect dracula-theme dashboard ctags-update counsel blackboard-theme auto-complete auctex))
 '(safe-local-variable-values
   '((eval setq cmake-ide-build-dir my-project-path)
     (eval setq cmake-ide-project-dir my-project-path)
     (eval message "Project directory set to `%s'." my-project-path)
     (eval set
	   (make-local-variable 'my-project-path)
	   (file-name-directory
	    (let
		((d
		  (dir-locals-find-file "./")))
	      (if
		  (stringp d)
		  d
		(car d)))))))
 '(shell-pop-autocd-to-working-dir t)
 '(shell-pop-cleanup-buffer-at-process-exit t)
 '(shell-pop-full-span t)
 '(shell-pop-restore-window-configuration t)
 '(shell-pop-shell-type
   '("ansi-term" "*ansi*"
     (lambda nil
       (ansi-term shell-pop-term-shell))))
 '(shell-pop-term-shell "/bin/bash")
 '(shell-pop-universal-key "C-a")
 '(shell-pop-window-position "bottom")
 '(sr-speedbar-auto-refresh t))
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
;;(require 'yasnippet)
;;(yas-reload-all)
;;(yas-global-mode 1)
(add-hook 'c++-mode-hook #'yas-minor-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;company 
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
;;  (defun company--my-insert-spc() (interactive) (company-abort)(insert-char #10r32))
;;   (defun company--my-insert-dot() (interactive) (company-abort)(insert-char #10r46))
   (define-key company-active-map (kbd "q") 'company-abort)
;;   (define-key company-active-map (kbd "SPC") 'company--my-insert-spc)
   ;;   (define-key company-active-map (kbd ".") 'company--my-insert-dot)
   )
(setq company-idle-delay 0)
;;(setq company-show-numbers t)
(defun my-c++mode-company-hook ()
  (setq company-minimum-prefix-length 3)
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
(global-set-key (kbd "C-c f") 'company-files)

(defun use-nonlsp()
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

;;;;;; flycheck
(setq flycheck-global-modes '(not org-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)
(global-set-key (kbd "C-c l") 'flycheck-list-errors)
(global-set-key (kbd "C-c <up>") 'flycheck-previous-error)
(global-set-key (kbd "C-c <down>") 'flycheck-next-error)


;;;;;;;;;;;;;;;;;; dashboard
;;(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-items '((recents  . 20)
                        (bookmarks . 5)
                        (agenda . 5)
                        (registers . 5)))


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
	    
))
;;(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)

;;;;;;;;;;;;;;;;;;;;;;; latex-math-preview
(autoload 'latex-math-preview-expression "latex-math-preview" nil t)
(autoload 'latex-math-preview-insert-symbol "latex-math-preview" nil t)
(autoload 'latex-math-preview-save-image-file "latex-math-preview" nil t)
(autoload 'latex-math-preview-beamer-frame "latex-math-preview" nil t)
(setq latex-math-preview-image-foreground-color "#ccffcc")




;(setq custom-file "~/.emacs.d/custom.el")
;(load custom-file)

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


(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 2
   kept-old-versions 1
   version-control t)       ; use versioned backups



(global-set-key (kbd "C-c m c") 'mc/edit-lines)


(defun xah-open-file-at-cursor ()
  "Open the file path under cursor.
If there is text selection, uses the text selection for path.
If the path starts with “http://”, open the URL in browser.
Input path can be {relative, full path, URL}.
Path may have a trailing “:‹n›” that indicates line number. If so, jump to that line number.
If path does not have a file extension, automatically try with “.el” for elisp files.
This command is similar to `find-file-at-point' but without prompting for confirmation.

URL `http://ergoemacs.org/emacs/emacs_open_file_path_fast.html'
Version 2019-01-16"
  (interactive)
  (let* (($inputStr (if (use-region-p)
                        (buffer-substring-no-properties (region-beginning) (region-end))
                      (let ($p0 $p1 $p2
                                ;; chars that are likely to be delimiters of file path or url, e.g. whitespace, comma. The colon is a problem. cuz it's in url, but not in file name. Don't want to use just space as delimiter because path or url are often in brackets or quotes as in markdown or html
                                ($pathStops "^  \t\n\"`'‘’“”|[]{}「」<>〔〕〈〉《》【】〖〗«»‹›❮❯❬❭〘〙·。\\"))
                        (setq $p0 (point))
                        (skip-chars-backward $pathStops)
                        (setq $p1 (point))
                        (goto-char $p0)
                        (skip-chars-forward $pathStops)
                        (setq $p2 (point))
                        (goto-char $p0)
                        (buffer-substring-no-properties $p1 $p2))))
         ($path
          (replace-regexp-in-string
           "^file:///" "/"
           (replace-regexp-in-string
            ":\\'" "" $inputStr))))
    (if (string-match-p "\\`https?://" $path)
        (if (fboundp 'xahsite-url-to-filepath)
            (let (($x (xahsite-url-to-filepath $path)))
              (if (string-match "^http" $x )
                  (browse-url $x)
		(message "not url, so find-file")
                (find-file $x)))
          (progn (browse-url $path)))
      (if ; not starting “http://”
          (string-match "^\\`\\(.+?\\):\\([0-9]+\\)\\'" $path)
          (let (
                ($fpath (match-string 1 $path))
                ($line-num (string-to-number (match-string 2 $path))))
            (if (file-exists-p $fpath)
                (progn
;		  (message "im here now")
                  (find-file $fpath)
                  (goto-char 1)
                  (forward-line (1- $line-num)))
              (when (y-or-n-p (format "file no exist: 「%s」. Create?" $fpath))
                (find-file $fpath))))
        (if (file-exists-p $path)
            (progn ; open f.ts instead of f.js
;	      (message "im down here")
              (let (($ext (file-name-extension $path))
                    ($fnamecore (file-name-sans-extension $path)))
;		(message $ext)
;		(message $fnamecore)
                (if (and (string-equal $ext "js")
                         (file-exists-p (concat $fnamecore ".ts")))
                    (find-file (concat $fnamecore ".ts"))
                  (find-file $path))
;		(message $path)
		))
          (if (file-exists-p (concat $path ".el"))
              (find-file (concat $path ".el"))
            (when (y-or-n-p (format "file no exist: 「%s」. Create?" $path))
              (find-file $path ))))))))


;;;;;;;;;;;;option + mouse cannot be defined in terminal emacs, cmd+mouse is intercepted by iterm2, ctrl + mouse is predefined in window emacs, so only left S+mouse choice
(global-set-key (kbd "S-<down-mouse-1>")  'mouse-set-point)
(global-set-key (kbd "S-<mouse-1>")  'xah-open-file-at-cursor)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;(add-to-list 'load-path "~/.emacs.d/themes/")
;(require 'moe-theme)

(powerline-default-theme)
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


;;; '(term-char-mode-buffer-read-only nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-highlight-prompt ((t (:foreground "magenta"))))
 '(isearch ((t (:inherit region :background "brightyellow" :foreground "#1B1E1C"))))
 '(lazy-highlight ((t (:inherit highlight :background "#FF99999")))))




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



(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
(setq tramp-verbose 1)


;;(use-nonlsp)
(use-lsp)

(setq gc-cons-threshold (* 5 1000 1000))

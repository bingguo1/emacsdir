

(defun unique-term ()
  (interactive)
  (call-interactively 'term)
  (rename-uniquely))

(setq shell-file-name "/bin/bash")
;;;;(setq explicit-shell-file-name "/bin/bash") ;;; <---- this doesn't help on "stop promping /bin/bash when open a term"
(global-set-key (kbd "C-t") 'unique-term)





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
	    (define-key term-raw-map (kbd "M-<right>")    'term-send-Mright)
	    (define-key term-raw-map (kbd "M-<left>")    'term-send-Mleft)
	    (define-key term-raw-map (kbd "<home>")    'my-term-send-home) 
	    (define-key term-raw-map (kbd "<end>")    'my-term-send-end)
	    (define-key term-raw-map (kbd "S-<left>")    'my-term-send-home) 
	    (define-key term-raw-map (kbd "S-<right>")    'my-term-send-end)
	    
    ))

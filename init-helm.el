(use-package helm
  :ensure t
    :defer t
    :init
    ;;    (setq-default recent-save-file "~/.emacs.d/recentf")
    (setq helm-split-window-in-side-p t)  ;;;;; without this, when sr-speedbar is present, helm minibuffer will occupy the existing buffer 
    :bind (("M-x" . helm-M-x)
	   ("C-x C-f" . helm-find-files)
	   ("C-x C-r" .  helm-recentf))
    :config
    (message "load helm now")
    (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
    (require 'helm-config)   
					;  (helm-mode 1)  ;;;; <-- donot turn on helm mode everywhere, in ESHELL, helm will mess up the auto-completion   
    )

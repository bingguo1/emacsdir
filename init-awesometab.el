
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

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

(require 'awesome-tab)
(awesome-tab-mode t)
(setq awesome-tab-buffer-groups-function 'my-tabbar-buffer-groups)
(when window-system
    (setq awesome-tab-active-bar-height 9
	  awesome-tab-height 100))


(use-package awesome-tab

  :bind (("C-<left>" . awesome-tab-backward-tab)
	 ("C-<right>" . awesome-tab-forward-tab)
	 ("C-<down>" . awesome-tab-forward-group)
	 ("C-<up>" . awesome-tab-backward-group)
	 ("C-q" . kill-this-buffer)
	 ("C-S-<left>" . awesome-tab-move-current-tab-to-left)
	 ("C-S-<right>" . awesome-tab-move-current-tab-to-right)
  ))

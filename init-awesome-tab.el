
(defun my-tabbar-buffer-groups ()
  (list
   (cond
    ((and  (string-equal "*" (substring (buffer-name) 0 1)) (string-equal "*tra" (substring (buffer-name) 0 4)))
     "Emacs")
    ((file-remote-p default-directory)
     "remote")
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


(when window-system
  (setq awesome-tab-active-bar-height 12
	    awesome-tab-height 110))
(setq awesome-tab-buffer-groups-function 'my-tabbar-buffer-groups)
(require 'awesome-tab)
(awesome-tab-mode t)
(global-set-key (kbd "C-<left>") 'awesome-tab-backward-tab)
(global-set-key (kbd "C-<right>") 'awesome-tab-forward-tab)
(global-set-key (kbd "C-<down>") 'awesome-tab-forward-group)
(global-set-key (kbd "C-<up>") 'awesome-tab-backward-group)
(global-set-key (kbd "C-q") 'kill-this-buffer)
(global-set-key (kbd "C-S-<left>") 'awesome-tab-move-current-tab-to-left)
(global-set-key (kbd "C-S-<right>") 'awesome-tab-move-current-tab-to-right)

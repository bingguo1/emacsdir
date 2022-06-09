;;;;;; flycheck
(setq flycheck-global-modes '(not org-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)
(global-set-key (kbd "C-c l") 'flycheck-list-errors)
(global-set-key (kbd "C-c <up>") 'flycheck-previous-error)
(global-set-key (kbd "C-c <down>") 'flycheck-next-error)


(defun my-set-margins ()  ;;;; the purpose is to show flycheck error indicatioin on left margin, at least 3 to let it appear
  "Set margins in current buffer."
  (setq left-margin-width 3)
  (setq right-margin-width 0))
(add-hook 'prog-mode-hook 'my-set-margins)

(use-package clipetty
  :hook (after-init . global-clipetty-mode)
  :bind (("s-c" . clipetty-kill-ring-save))
  )

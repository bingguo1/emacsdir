

(setq gc-cons-threshold (* 50 1024 1024)
      read-process-output-max (* 1024 1024)
      )

(load-file "~/.emacs.d/init-package.el")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ace-jump-mode desktop+ workgroups2 perspective cmake-ide lsp-mode shell-pop yasnippet helm web-mode awesome-tab use-package cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(load-file "~/.emacs.d/init-awesometab.el")
(load-file "~/.emacs.d/init-webdev.el")
(load-file "~/.emacs.d/init-c.el")
(load-file "~/.emacs.d/init-helm.el")
(load-file "~/.emacs.d/init-za.el")
(load-file "~/.emacs.d/init-termshell.el")
(load-file "~/.emacs.d/init-shortcuts.el")

(load-file "~/.emacs.d/init-yasnippet.el")
(load-file "~/.emacs.d/init-shellpop.el")


;;(load-file "~/.emacs.d/init-mac.el")
(load-file "~/.emacs.d/init-linux.el")

(load-file "~/.emacs.d/init-company.el")
;;(load-file "~/.emacs.d/init-flycheck.el")
;;(load-file "~/.emacs.d/init-dashboard.el")
;;(load-file "~/.emacs.d/init-projectile.el")

(load-file "~/.emacs.d/init-xah.el")

(load-file "~/.emacs.d/init-theme.el")

;;(load-file  "~/.emacs.d/init-lsp.el")

;;(load-file "~/.emacs.d/init-mouse.el")
(load-file "~/.emacs.d/init-acejump.el")


(load-file "~/.emacs.d/init-org.el")
(load-file "~/.emacs.d/init-desktop.el")
;;(load-file "~/.emacs.d/init-perspective.el")
;;(load-file "~/.emacs.d/init-workgroups2.el")



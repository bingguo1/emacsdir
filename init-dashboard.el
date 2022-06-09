;;;;;;;;;;;;;;;;;; dashboard
(use-package dashboard
  :ensure t
  :init
  (setq dashboard-items '((recents  . 20)
			  (projects . 5)
                     (bookmarks . 5)
                     (agenda . 5)
                     (registers . 5)))
  :config
  (dashboard-setup-startup-hook))

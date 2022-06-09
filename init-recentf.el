(require 'recentf)
(setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
(setq recentf-max-saved-items 200)
(run-at-time nil (* 15 60) 'recentf-save-list)
(recentf-mode 1)

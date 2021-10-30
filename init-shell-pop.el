

(global-set-key  (kbd "C-a") 'shell-pop)

(use-package shell-pop
  :init
  (setq shell-pop-autocd-to-working-dir t
	    shell-pop-cleanup-buffer-at-process-exit t
        ;;	shell-pop-full-span t    ;;; do not use this, when sr-speedbar is present and shell-pop is showing, C-x 1 will not make shell-pop window occupy full
	    shell-pop-restore-window-configuration t
	    shell-pop-shell-type
	    '("ansi-term" "*ansi*"
	      (lambda nil
	        (ansi-term shell-pop-term-shell)))
	    shell-pop-term-shell "/bin/bash"
	    shell-pop-universal-key "C-a"
	    shell-pop-window-position "bottom")
  )

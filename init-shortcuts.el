

;;;;;;;;;;;;;;;;;; desktop + ;;;;;;;;;;;;;;;;;;;;;;;;
(global-unset-key (kbd "C-d"))
(global-set-key (kbd "C-d c") 'desktop+-create)
(global-set-key (kbd "C-d l") 'desktop+-load)
(global-set-key (kbd "C-d a") 'desktop-change-dir)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)
(global-set-key (kbd "C-o") 'occur)

(global-unset-key (kbd "C-x b"))
(global-set-key (kbd "C-x b s") 'bookmark-set)
(global-set-key (kbd "C-x b l") 'list-bookmarks)
(global-set-key (kbd "C-x b j") 'bookmark-jump)


(global-set-key (kbd "S-<up>") 'scroll-down-command)
(global-set-key (kbd "S-<down>") 'scroll-up-command)
(global-set-key (kbd "S-<left>") 'move-beginning-of-line)
(global-set-key (kbd "S-<right>") 'move-end-of-line)


(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "M-w") 'kill-region)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)


(global-set-key (kbd "C-c k") #'compile)
(global-set-key (kbd "C-c r") #'recompile)
(global-set-key (kbd "s-u") 'revert-buffer)
(global-set-key (kbd "C-c m c") 'mc/edit-lines)
;;;;;;;;;;;;option + mouse cannot be defined in terminal emacs, cmd+mouse is intercepted by iterm2, ctrl + mouse is predefined in window emacs, so only left S+mouse choice
(global-set-key (kbd "S-<down-mouse-1>")  'mouse-set-point)
(global-set-key (kbd "S-<mouse-1>")  'xah-open-file-at-cursor)

(global-set-key (kbd "C-\\") 'comment-region)
(global-set-key (kbd "C-M-\\") 'uncomment-region)
(global-set-key (kbd "C-x r") 'find-file-read-only)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "s-b") 'neotree-toggle)
(global-set-key (kbd "s-/") 'comment-dwim)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "M-f") 'indent-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-M-<left>") 'windmove-left)
(global-set-key (kbd "C-M-<right>") 'windmove-right)
(global-set-key (kbd "C-M-<up>") 'windmove-up)
(global-set-key (kbd "C-M-<down>") 'windmove-down)
(global-set-key (kbd "<end>") 'move-end-of-line)
(global-set-key (kbd "<home>") 'move-beginning-of-line)

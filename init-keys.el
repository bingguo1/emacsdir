(global-unset-key (kbd "<magnify-up>"))
(global-unset-key (kbd "<magnify-down>"))

(global-set-key  (kbd "s-/") 'comment-or-uncomment-region)


(global-set-key (kbd "C-x <xleft>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "<end>") 'move-end-of-line)
(global-set-key (kbd "<home>") 'move-beginning-of-line)

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

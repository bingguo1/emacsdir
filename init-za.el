

(electric-pair-mode 1)

(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'mmm-mode-hook 'linum-mode)


(toggle-scroll-bar -1)

(unless window-system (menu-bar-mode -1))
(fset 'yes-or-no-p 'y-or-n-p)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 2
   kept-old-versions 1
   version-control t)       ; use versioned backups


(defun delete-line (&optional arg)
  "Delete text from current position to end of line char.  This command does not push text to `kill-ring'.  with or without ARG"
  (interactive "P")
  (delete-region (point)
   (progn
     (if arg
         (forward-visible-line (prefix-numeric-value arg))
       (if (eobp)
           (signal 'end-of-buffer nil))
       (let ((end
              (save-excursion
                (end-of-visible-line) (point))))
         (if (or (save-excursion
                   ;; If trailing whitespace is visible,
                   ;; don't treat it as nothing.
                   (unless show-trailing-whitespace
                     (skip-chars-forward " \t" end))
                   (= (point) end))
                 (and kill-whole-line (bolp)))
             (forward-visible-line 1)
           (goto-char end))))
     (point))))
(global-set-key  (kbd "C-k") 'delete-line)

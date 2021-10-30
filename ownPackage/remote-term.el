;;; remote-term.el -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Nic Ferrier

;; Author: Bing Guo <bingguo0625@gmail.com>
;; Keywords: remote, term, tramp
;; Version: 0.0.1


(require 'tramp-term)

;;;###autoload
(defun remote-term ()
  "Create an ansi-term running ssh session and automatically
enable tramp integration in that terminal.  Optional argument
HOST-ARG is a list or one or two elements, the last of which is
the host name."
  (interactive)
  (let* ((path default-directory)
         (tstruct (tramp-dissect-file-name path))
         (path (tramp-file-name-localname tstruct))
         (user (tramp-file-name-user tstruct))
         (hostname (tramp-file-name-host tstruct)))
      (unless (eql (catch 'tramp-term--abort (tramp-term--do-ssh-login2 hostname user path)) 'tramp-term--abort)
        (tramp-term--initialize hostname)
        (run-hook-with-args 'tramp-term-after-initialized-hook hostname)
        (message "tramp-term initialized"))))

(defun tramp-term--do-ssh-login2 (host user path)
  "Perform the ssh login dance."
  (tramp-term--create-term2 host "ssh" host user path)
  (save-excursion
    (let ((bound 0))
      (while (not (tramp-term--find-shell-prompt bound))
        (let ((yesno-prompt (tramp-term--find-yesno-prompt bound))
              (passwd-prompt (tramp-term--find-passwd-prompt bound))
              (service-unknown (tramp-term--find-service-unknown bound)))
          (cond (yesno-prompt
                 (tramp-term--confirm)
                 (setq bound (1+ yesno-prompt)))
                (passwd-prompt
                 (tramp-term--handle-passwd-prompt)
                 (setq bound (1+ passwd-prompt)))
                (service-unknown (throw 'tramp-term--abort 'tramp-term--abort))
                (t (sleep-for 0.1))))))))

(defun tramp-term--create-term2 (new-buffer-name cmd host user path)
  "Create an ansi-term running an arbitrary command, including
extra parameters."
  (let ((new-buffer-name (generate-new-buffer-name (format "*%s*" new-buffer-name))))
    ;;     (switches (list "-t" host "-l" user "-p" port "$SHELL -c" "\" cd /dune/app/users/mylab/ndwork/stt/prism; $SHELL\"")))
    (setq switches (list "-t" host "-l" user "$SHELL -c" "\" cd" path "; $SHELL\""))
     (with-current-buffer  (apply 'make-term new-buffer-name cmd nil switches)
       (rename-buffer new-buffer-name)   ; Undo the extra "*"s that
                                        ; make-term insists on adding
      (term-mode)
      (term-char-mode)
      (term-set-escape-char ?\C-x))
    (switch-to-buffer new-buffer-name)))



(provide 'remote-term)
;;; remote-term.el ends here

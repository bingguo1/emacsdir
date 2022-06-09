;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; org ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (with-eval-after-load 'org
;;   (require 'org-tempo) ;;;; enable the old way to create a block by < + key + <tab>
;;   (global-set-key (kbd "C-c o l") 'org-store-link)
;;   (global-set-key (kbd "C-c o a") 'org-agenda)
;;   (global-set-key (kbd "C-c o c") 'org-capture)
;;   (setq org-image-actual-width nil)
  
;;   (require 'org-download)
;;   ;; Drag-and-drop to `dired`
;;   (add-hook 'dired-mode-hook 'org-download-enable)
;;   (with-eval-after-load 'org
;;     (org-download-enable))
  
;;   (unless (string= (user-login-name) "mylab")
;;     (setq org-default-notes-file "~/doc_emacs/orgs/tasks.org")
;;     (setq org-agenda-files '("~/doc_emacs/orgs/agenda/"))
;;     )
  
;;   (require 'ox-latex)
;;   (add-to-list 'org-latex-classes
;;                '("beamer"
;; 		 "\\documentclass\[presentation\]\{beamer\}"
;; 		 ("\\section\{%s\}" . "\\section*\{%s\}")
;; 		 ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
;; 		 ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
;;   )

;;;;;;;;;;; yas
;;(require 'yasnippet)
;;(yas-reload-all)
;;(yas-global-mode 1)
(use-package yasnippet
  :ensure t
  :hook (c++-mode . yas-minor-mode)
  :bind
  (:map yas-minor-mode-map
        ("C-c y t" . yas-describe-tables)  ;; learn from https://lupan.pl/dotemacs/
;        ("C-c & &" . org-mark-ring-goto)
	))

(use-package yasnippet-snippets
  :defer)
;;(add-hook 'c++-mode-hook #'yas-minor-mode)

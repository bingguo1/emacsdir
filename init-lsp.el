(use-package lsp-mode
  :ensure t
    :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
            (c++-mode . lsp)
            ;; if you want which-key integration
            (lsp-mode . lsp-enable-which-key-integration))
    :commands lsp
    :defer 0.5
    :init
    (setq lsp-keymap-prefix "M-l"
	  lsp-enable-imenu nil ;; if true, this will mess up the sr-speedbar imenu 
	  lsp-enable-indentation nil
	  lsp-enable-on-type-formatting nil
	  )
;    :config    (require 'dap-gdb-lldb)
    :bind (:map lsp-mode-map
		("S-<down-mouse-1>" . mouse-set-point)
		("S-<mouse-1>" . lsp-find-definition-mouse)
		("M-." . lsp-find-definition)
		("M-/" . lsp-find-references))
)

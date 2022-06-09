(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0  ; avoid auto completion popup, use TAB
					; to show it
	company-auto-commit nil
        company-tooltip-align-annotations nil
	company-minimum-prefix-length 3)
  :hook (after-init . global-company-mode)
  :bind (("C-c f" . company-files)
	 :map company-active-map
	 ("q" . company-abort)
	 ))

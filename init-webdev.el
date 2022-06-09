
(setq-default indent-tabs-mode nil)

(add-hook 'mmm-mode-hook
          (lambda ()
	    ;;	    (setq tab-width 4)        ;; set your desired tab width
	    (setq indent-tabs-mode nil) ;; use tabs for indentation
	    ))

(add-hook 'html-mode-hook
	  (lambda ()
	    (set (make-local-variable 'sgml-basic-offset) 4)
	    ;;	    (setq tab-width 4)        ;; set your desired tab width
	    ;;	    (setq indent-tabs-mode t) ;; use tabs for indentation
	    ))


(use-package web-mode
  :ensure  t)

;;(require 'web-mode)
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-block-face t)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("blade"  . "\\.blade\\."))
)

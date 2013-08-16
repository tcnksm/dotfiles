;; ==================================================
;; YAML SETTING
;; ==================================================
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


;; --------------------------------------------------
;; hook
;; --------------------------------------------------
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


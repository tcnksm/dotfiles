;; ==================================================
;; HAML SETTING
;; ==================================================
;; Install it manually from github
(require 'haml-mode nil t)

;; --------------------------------------------------
;; Open as ruby-mode
;; --------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

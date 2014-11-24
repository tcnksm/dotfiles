;; ==================================================
;; auto-insert.el
;; ==================================================
(require 'autoinsert)
(auto-insert-mode 1)
(setq auto-insert-query 1)
(setq auto-insert-directory "~/.emacs.d/etc/insert/")
(define-auto-insert "\.rb" "template.rb")
(define-auto-insert "\.service" "template.service")
(define-auto-insert "README\.md" "template.md")


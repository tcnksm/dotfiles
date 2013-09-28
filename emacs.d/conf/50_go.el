;; ==================================================
;; GOLANG SETTING
;; ==================================================

;; --------------------------------------------------
;; Go mode
;; --------------------------------------------------
(require 'go-mode nil t)

;; --------------------------------------------------
;; Open as go-mode
;; --------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))

;; --------------------------------------------------
;; Auto complete
;; --------------------------------------------------
;; (require 'go-autocomplete nil t)

;; --------------------------------------------------
;; Syntax check 
;; --------------------------------------------------
;; (if (file-exists-p "~/.goenv/src/github.com/dougm/goflymake")
;;     (add-to-list 'load-path "~/.goenv/src/github.com/dougm/goflymake"))
;; (require 'go-flymake nil t)
;; (flymake-mode t)

;; --------------------------------------------------
;; Use go get tools
;; --------------------------------------------------
;; (if (file-exists-p "~/.goenv/bin")
;;     (add-to-list 'exec-path (expand-file-name "~/.goenv/bin")))

;; --------------------------------------------------
;; Arrage code before save
;; --------------------------------------------------
(add-hook 'before-save-hook 'gofmt-before-save)

;; --------------------------------------------------
;; Jump to definition
;; --------------------------------------------------
;; (add-hook 'go-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "M-j") 'godef-jump)
;;              (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
;;              (local-set-key (kbd "C-c i") 'go-goto-imports)))


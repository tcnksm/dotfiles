;; ==================================================
;; PROTOBUF SETTING
;; ==================================================

;; --------------------------------------------------
;; protobuf mode
;; $ ghq get github.com/google/protobuf
;; --------------------------------------------------
(load-file (concat (getenv "GOPATH") "/src/github.com/google/protobuf/editors/protobuf-mode.el"))
(require 'protobuf-mode nil t)

(add-to-list 'auto-mode-alist '("\\.proto$" . protobuf-mode))

;; --------------------------------------------------
;; smartchr
;; --------------------------------------------------
(require 'smartchr nil t)

(defun smartchr-go ()
  (local-set-key (kbd "(") (smartchr '("(`!!')" "()`!!'" "(")))
  (local-set-key (kbd "{") (smartchr '("{`!!'}" "{\n`!!'\n}" "{")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[")))
  )

(add-hook 'protobuf-mode-hook 'smartchr-go)


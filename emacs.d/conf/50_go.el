;; ==================================================
;; GO SETTING
;; ==================================================

;; --------------------------------------------------
;; Go mode 
;; --------------------------------------------------
(require 'go-mode nil t)


;; --------------------------------------------------
;; Using command instal by go get
;; --------------------------------------------------
(add-to-list 'exec-path (expand-file-name "~/bin"))


;; --------------------------------------------------
;; Arrange source code before saving
;; --------------------------------------------------
(add-hook 'before-save-hook 'gofmt-before-save)


;; --------------------------------------------------
;; Keybind
;; $ go get code.google.com/p/go.tools/cmd/godoc
;; $ go get code.google.com/p/rog-go/exp/cmd/godef
;; --------------------------------------------------
(defun go-keybind ()
  (local-set-key (kbd "\C-c d") 'godoc)          ;; Search doc
  (local-set-key (kbd "\C-c j") 'godef-jump)     ;; Jump to definition
  (local-set-key (kbd "\C-c p") 'go-import-add)  ;; Import package
  (local-set-key (kbd "\C-c u") 'go-remove-unused-imports) ;; Remove unused package
  (local-set-key (kbd "\C-c ,")     'go-play-region) ;;
  )

(add-hook 'go-mode-hook 'go-keybind)


;; --------------------------------------------------
;; Complete
;; $ go get code.google.com/p/rog-go/exp/cmd/godef
;; $ go get -u github.com/nsf/gocode
;; --------------------------------------------------
(add-to-list 'load-path (concat (getenv "GOPATH") "/src/github.com/nsf/gocode/emacs/"))
(require 'go-autocomplete nil t)
(require 'auto-complete-config nil t)


;; --------------------------------------------------
;; Flymake
;; $ go get github.com/dougm/goflymake
;; --------------------------------------------------
(add-to-list 'load-path (concat (getenv "GOPATH") "/src/github.com/dougm/goflymake"))
(require 'go-flymake nil t)

;; --------------------------------------------------
;; Eldoc, show arguments type
;; --------------------------------------------------
(require 'go-eldoc nil t)
(add-hook 'go-mode-hook 'go-eldoc-setup)


;; --------------------------------------------------
;; go lint
;; $ go get -u github.com/golang/lint/golint
;; --------------------------------------------------
(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require 'golint nil t)
(define-key go-mode-map (kbd "\C-c l") 'golint)

;; --------------------------------------------------
;; go-direx
;; go get -u github.com/jstemmer/gotags
;; --------------------------------------------------
(require 'go-direx nil t) ;; Don't need to require, if you install by package.el
(define-key go-mode-map (kbd "C-c C-j") 'go-direx-pop-to-buffer)

;; --------------------------------------------------
;; smartchr
;; --------------------------------------------------
(require 'smartchr nil t)

(defun smartchr-go ()
  (local-set-key (kbd "+") (smartchr '("+" " + " " += " " ++ ")))
  (local-set-key (kbd "-") (smartchr '("-" " - " " -= " " -- ")))
  (local-set-key (kbd "=") (smartchr '("=" " = " " := " " != " " == ")))
  (local-set-key (kbd ";") (smartchr '("; " ";")))
  (local-set-key (kbd ">") (smartchr '(" > " " -> " ">")))
  (local-set-key (kbd "<") (smartchr '(" < " " <- " "<")))  
  (local-set-key (kbd "(") (smartchr '("(`!!')" "()`!!'" "(")))
  (local-set-key (kbd "{") (smartchr '("{`!!'}" "{\n`!!'\n}" "{")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[")))
  )

(add-hook 'go-mode-hook 'smartchr-go)


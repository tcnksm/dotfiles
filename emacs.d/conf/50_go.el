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
;; Go imports
;; go get golang.org/x/tools/cmd/goimports
;; --------------------------------------------------
(setq gofmt-command "goimports")

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
  (local-set-key (kbd "\C-c d") 'godoc)               ;; Search doc
  (local-set-key (kbd "\C-c j") 'godef-jump)          ;; Jump to definition
  (local-set-key (kbd "\C-c b") 'pop-tag-mark)        ;; Back to jump source
  (local-set-key (kbd "\C-c p") 'go-import-add)       ;; Import package
  (local-set-key (kbd "\C-c t") 'gotests)             ;; Remove unused package
  (local-set-key (kbd "\C-c ,") 'go-play-region)      ;;
  )
(add-hook 'go-mode-hook 'go-keybind)


;; --------------------------------------------------
;; Complete
;; $ go get code.google.com/p/rog-go/exp/cmd/godef
;; $ go get -u github.com/nsf/gocode
;; --------------------------------------------------
(add-to-list 'load-path (concat (getenv "GOPATH") "/src/github.com/nsf/gocode/emacs/"))

(require 'company-go nil t)
(setq company-begin-commands '(self-insert-command))
(setq company-idle-delay .3)
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))


;; --------------------------------------------------
;; Flymake
;; $ go get github.com/dougm/goflymake
;; --------------------------------------------------
;; (add-to-list 'load-path (concat (getenv "GOPATH") "/src/github.com/dougm/goflymake"))
;; (require 'go-flymake nil t)

;; --------------------------------------------------
;; guru https://github.com/golang/tools/commit/69f6f5b782e1f090edb33f68be67d96673a8059e
;; --------------------------------------------------
;; (load-file (concat (getenv "GOPATH") "/src/golang.org/x/tools/cmd/guru/go-guru.el"))
(require 'go-guru nil t)
(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
(set-face-background 'show-paren-match-face "#f0f8ff") ; change emphasis color
(set-face-attribute 'go-guru-hl-identifier-face nil
                     :background "#ffff00")


;; --------------------------------------------------
;; gorename
;; --------------------------------------------------
;; (load-file (concat (getenv "GOPATH") "/src/golang.org/x/tools/refactor/rename/go-rename.el"))


;; --------------------------------------------------
;; gotests
;; --------------------------------------------------
(load-file (concat (getenv "GOPATH") "/src/github.com/tcnksm/gotests/editor/emacs/gotests.el"))

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
(require 'go-direx nil t)
(define-key go-mode-map (kbd "C-c C-j") 'go-direx-pop-to-buffer)

(require 'go-rename nil t)

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


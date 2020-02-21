;; ==================================================
;; General 
;; ==================================================

;; --------------------------------------------------
;; initial 
;; --------------------------------------------------
(require 'cask "/usr/local/opt/cask/cask.el") 
(cask-initialize)

(setq initial-scratch-message nil) 
(setq inhibit-startup-message t)  

;; --------------------------------------------------
;; Font
;; --------------------------------------------------
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 150) ; font, font size

;; --------------------------------------------------
;; Mode line
;; --------------------------------------------------
(size-indication-mode t)           
(setq display-time-24hr-fomat t)   
(setq display-time-day-and-date t) 
(display-time-mode t)              
(setq line-number-mode t)          
(setq column-number-mode t)        
(fset 'yes-or-no-p 'y-or-n-p)      

;; --------------------------------------------------
;; Display
;; --------------------------------------------------
(show-paren-mode 1)
(global-linum-mode 0)                                   
(menu-bar-mode -1)                                      
(setq frame-title-format (format "%%f" (system-name)))  

(when window-system
  (tool-bar-mode nil)                                   
  (set-scroll-bar-mode nil)                             
  )

;; --------------------------------------------------
;; Cursor
;; --------------------------------------------------
(blink-cursor-mode 1)
(cond
 (window-system
  (setq x-select-enable-clipboard t)))

;; --------------------------------------------------
;; Encoding
;; --------------------------------------------------
(prefer-coding-system 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)

;; --------------------------------------------------
;; Backup file
;; --------------------------------------------------
(setq make-backup-files nil)   
(setq delete-auto-savefiles t) 
(setq auto-save-list-file-prefix nil)
(setq auto-save-default nil)

;; --------------------------------------------------
;; Meta key
;; --------------------------------------------------
(setq ns-command-modifier (quote meta))

;; --------------------------------------------------
;; Indent
;; --------------------------------------------------
(setq-default indent-tabs-mode nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (lsp-mode yaml-mode undohist undo-tree toml-mode terraform-mode smartchr protobuf-mode markdown-mode highlight-symbol helm-ghq helm-ag go-rename go-guru go-eldoc git-gutter dockerfile-mode direx company-quickhelp company-go color-theme-sanityinc-tomorrow cask)))
 '(tab-width 4))

;; --------------------------------------------------
;; Completion
;; --------------------------------------------------
(setq completion-ignore-case t)                  
(setq read-file-name-completion-ignore-case t)   

;; --------------------------------------------------
;; Paren mode
;; --------------------------------------------------
(global-hl-line-mode t)
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)

;; --------------------------------------------------
;; recentf mode
;; --------------------------------------------------
(recentf-mode t)
(setq recentf-max-menu-items 10)            
(setq recentf-max-saved-items 3000)         
(setq recentf-save-file "/tmp/recentf")

;; --------------------------------------------------
;; Save hist mode
;; --------------------------------------------------
(savehist-mode 1)
(setq history-length 3000)
(setq savehist-file "/tmp/history")

;; --------------------------------------------------
;; Cua mode
;; --------------------------------------------------
(cua-mode t)
(setq cua-enable-cua-keys nil)
(global-set-key (kbd "C-c c") 'cua-set-rectangle-mark) 

;; --------------------------------------------------
;; Uniquify
;; --------------------------------------------------
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; --------------------------------------------------
;; Don't use C-x C-c
;; --------------------------------------------------
(global-set-key "\C-x\C-c" 'helm-recentf)
(defalias 'exit 'save-buffers-kill-emacs)

;; --------------------------------------------------
;; server mode
;; [reference] http://qiita.com/items/2bdcd9cd5b701b1112e6
;; --------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))

;; --------------------------------------------------
;; Copy by mouse drag
;; --------------------------------------------------
(setq select-active-regions nil)
(setq mouse-drag-copy-region t)
(setq x-select-enable-primary t)
(setq select-active-regions nil)

;; --------------------------------------------------
;; Excutable start with '#!' 
;; --------------------------------------------------
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; --------------------------------------------------
;; Show all "eval" result
;; --------------------------------------------------
(setq eval-expression-print-length nil)

;; ==================================================
;; Keybind
;; ==================================================
;; Move
(global-set-key "\C-f" 'forward-word)
(global-set-key "\C-b" 'backward-word)

;; Delete backward
(global-set-key "\C-h" 'backward-delete-char)

;; Comment out
(global-set-key "\C-x\C-x" 'comment-region)
(global-set-key "\C-xt" 'uncomment-region)

(global-set-key "\C-d" 'copy-region-as-kill)
(global-set-key "\C-w" 'kill-region)

;; Replace once
(global-set-key "\C-cr" 'replace-string)

;; Replace interactively
(global-set-key "\C-cq" 'query-replace)

;; Auto indent
(global-set-key "\C-m" 'newline-and-indent)          

;; Move by line number
(global-set-key "\C-c\C-g" 'goto-line)

;; Grep
(global-set-key "\M-g" 'grep)

;; ==================================================
;; git-gutter
;; ==================================================
(require 'git-gutter nil t)
;; (global-git-gutter-mode t)

;; ==================================================
;; Highlight symbol
;; ==================================================
(require 'highlight-symbol nil t)
(global-set-key (kbd "C-]") 'highlight-symbol-next)

;; ==================================================
;; Undo/Redo
;; ==================================================
(require 'undo-tree nil t) 
(global-undo-tree-mode 1)

;; --------------------------------------------------
;; Remain after emacs is closed
;; --------------------------------------------------
(require 'undohist nil t)
(setq undohist-directory "/tmp/undohist")
(undohist-initialize)

;; --------------------------------------------------
;; Keybind
;; --------------------------------------------------
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-z")   'undo) 
(global-set-key (kbd "C-S-z") 'redo)

;; ==================================================
;; helm.el
;; ==================================================
(require 'helm-config)
(helm-mode 1)

;; -------------------------------------------------
;; Keybind (run)
;; -------------------------------------------------
(global-set-key (kbd "C-x C-f") 'helm-find-files) 
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-k") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-g") 'helm-do-ag)
(global-set-key (kbd "C-x C-j") 'helm-ghq)
(global-set-key (kbd "C-x C-o") 'helm-occur)

;; -------------------------------------------------
;; Keybind (while executing helm)
;; -------------------------------------------------
(define-key helm-read-file-map  (kbd "C-h") 'delete-backward-char)
(define-key helm-read-file-map  (kbd "TAB") 'helm-execute-persistent-action)

(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "C-f") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "C-j") 'helm-execute-persistent-action)

;; ==================================================
;; Company
;; ==================================================
(require 'company nil t)
(global-company-mode t)

(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)

;; --------------------------------------------------
;; Keybind at showing candidates
;; --------------------------------------------------
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; ==================================================
;; GO 
;; ==================================================

;; --------------------------------------------------
;; Go mode 
;; --------------------------------------------------
(require 'go-mode nil t)
(require 'lsp-mode nil t)
(require 'lsp-ui nil t)

(add-hook 'go-mode-hook 'lsp-deferred)
(add-to-list 'exec-path (expand-file-name "~/bin"))

;; --------------------------------------------------
;; Go imports
;; go get golang.org/x/tools/cmd/goimports
;; --------------------------------------------------
(setq gofmt-command "goimports")

;; --------------------------------------------------
;; Go fmt before saving
;; --------------------------------------------------
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; --------------------------------------------------
;; Eldoc, show arguments type
;; --------------------------------------------------
(require 'go-eldoc nil t)
(add-hook 'go-mode-hook 'go-eldoc-setup)

;; --------------------------------------------------
;; Complete
;; --------------------------------------------------
(require 'company-go nil t)
(require 'company-lsp nil t)

(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (set (make-local-variable 'company-backends) '(company-lsp))
                          (company-mode)))

;; --------------------------------------------------
;; Keybind
;; --------------------------------------------------
(defun go-keybind ()
  (local-set-key (kbd "\C-c j") 'lsp-find-definition)          ;; Jump to definition
  (local-set-key (kbd "\C-c b") 'pop-tag-mark)        ;; Back to jump source
  )
(add-hook 'go-mode-hook 'go-keybind)

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

;; ==================================================
;; Configuration language
;; ==================================================

;; --------------------------------------------------
;; HCL
;; --------------------------------------------------
(require 'hcl-mode nil t)

;; --------------------------------------------------
;; Terraform
;; --------------------------------------------------
(require 'terraform-mode nil t)
(terraform-format-on-save-mode t)

(defun smartchr-tf ()
  (local-set-key (kbd "{") (smartchr '("{`!!'}" "{\n`!!'\n}" "{")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[")))
  )
(add-hook 'terraform-mode 'smartchr-tf)

;; --------------------------------------------------
;; Yaml
;; --------------------------------------------------
(require 'yaml-mode nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("spec" . yaml-mode))

;; --------------------------------------------------
;; TOML
;; --------------------------------------------------
(require 'toml-mode nil t)
(add-to-list 'auto-mode-alist '("\\.toml$" . toml-mode))

;; --------------------------------------------------
;; protobuf mode
;; --------------------------------------------------
(require 'protobuf-mode nil t)
(add-to-list 'auto-mode-alist '("\\.proto$" . protobuf-mode))

(defun smartchr-protobuf ()
  (local-set-key (kbd "(") (smartchr '("(`!!')" "()`!!'" "(")))
  (local-set-key (kbd "{") (smartchr '("{`!!'}" "{\n`!!'\n}" "{")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[")))
  )
(add-hook 'protobuf-mode-hook 'smartchr-protobuf)

;; --------------------------------------------------
;; Docker
;; --------------------------------------------------
(require 'dockerfile-mode nil t)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; --------------------------------------------------
;; Systemd
;; --------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.service$" . conf-mode))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

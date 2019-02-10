; ==================================================
;;
;; GLOBAL SETUP
;;
;; ==================================================

;; --------------------------------------------------
;; initial 
;; --------------------------------------------------
(setq initial-scratch-message nil) ; do not show starting message
(setq inhibit-startup-message t)   ; inhibits the startup screen

;; --------------------------------------------------
;; Color
;; --------------------------------------------------
(require 'color-theme-sanityinc-tomorrow nil t)

;; --------------------------------------------------
;; Font
;; --------------------------------------------------
;; English
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 150) ; font, font size

;; Japanese
(set-default-font "VL Gothic-11")

;; --------------------------------------------------
;; Mode line
;; --------------------------------------------------
(size-indication-mode t)           ; show file size
(setq display-time-24hr-fomat t)   ; set time 24 fomat
(setq display-time-day-and-date t) ; display day and date
(display-time-mode t)              ; display time
(setq line-number-mode t)          ; show line number
(setq column-number-mode t)        ; show column number
(fset 'yes-or-no-p 'y-or-n-p)      ; "yes or no " to "y or n"

;; --------------------------------------------------
;; Display
;; --------------------------------------------------
(show-paren-mode 1)
(global-linum-mode 0)                                    ; show line number at left side 
(menu-bar-mode -1)                                       ; do not show 'menu bar'
(setq frame-title-format (format "%%f" (system-name)))   ; show file path at title bar

(when window-system
  (tool-bar-mode nil)                                    ; do not show 'tool bar'
  (set-scroll-bar-mode nil)                              ; do not 'show scroll bar'
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
(setq make-backup-files nil)            ; do not create backup file
(setq delete-auto-savefiles t)          ; delete auto sage file when closing
(setq auto-save-list-file-prefix nil)   ; do not create auto-save-list
(setq auto-save-default nil)

;; --------------------------------------------------
;; Meta key
;; --------------------------------------------------
(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))


;; --------------------------------------------------
;; indent
;; --------------------------------------------------
;; (setq-default indent-tabs-mode nil)
;; (custom-set-variables '(tab-width 4))


;; --------------------------------------------------
;; completion
;; --------------------------------------------------
(setq completion-ignore-case t)                  ; dont distinguish characutor case
(setq read-file-name-completion-ignore-case t)   ; dont distinguish characutor case

;; --------------------------------------------------
;; paren mode
;; --------------------------------------------------
(global-hl-line-mode t)
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face "#808080") ; change emphasis color

;; --------------------------------------------------
;; recentf mode
;; --------------------------------------------------
(recentf-mode t)
(setq recentf-max-menu-items 10)            ; max display
(setq recentf-max-saved-items 3000)         ; max save
(setq recentf-save-file "~/.emacs.d/etc/.cache/recentf")

;; --------------------------------------------------
;; Save hist mode
;; --------------------------------------------------
(savehist-mode 1)
(setq history-length 3000)
(setq savehist-file "~/.emacs.d/etc/.cache/history")

;; --------------------------------------------------
;; Cua mode
;; --------------------------------------------------
(cua-mode t)
(setq cua-enable-cua-keys nil)
(global-set-key (kbd "C-c c") 'cua-set-rectangle-mark) ;; or C-RET


;; --------------------------------------------------
;; Uniquify
;; --------------------------------------------------
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)


;; --------------------------------------------------
;; Don't use C-x C-c
;; --------------------------------------------------
(global-set-key (kbd "C-x C-c") 'helm-recentf)
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

(global-set-key "\C-d" 'copy-region-as-kill)
(global-set-key "\C-w" 'kill-region)

;; (global-set-key "\C-xt" 'uncomment-region)
;; Un-comment out

;; Replace once
(global-set-key "\C-cr" 'replace-string)

;; Replace interactively
(global-set-key "\C-cq" 'query-replace)

;; Auto indent
(global-set-key "\C-m" 'newline-and-indent)          

;; New line
(global-set-key "\C-j" 'newline)

;; Move by line number
(global-set-key "\C-c\C-g" 'goto-line)

;; Grep
(global-set-key "\M-g" 'grep)

;; ==================================================
;; company
;; ==================================================
;; (require 'company nil t)
;; (global-company-mode t)

;; --------------------------------------------------
;; General settings
;; --------------------------------------------------
;; (setq company-idle-delay 0.2)
;; (setq company-minimum-prefix-length 1)

;; --------------------------------------------------
;; Keybind at showing candidates
;; --------------------------------------------------
;; (define-key company-active-map (kbd "C-n") 'company-select-next)
;; (define-key company-active-map (kbd "C-p") 'company-select-previous)
;; (define-key company-search-map (kbd "C-n") 'company-select-next)
;; (define-key company-search-map (kbd "C-p") 'company-select-previous)

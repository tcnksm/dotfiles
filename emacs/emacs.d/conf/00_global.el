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

;; Solarized
;; [install] git clone https://github.com/sellout/emacs-color-theme-solarized
;; (load-theme 'solarized-light t) ;; emacs24


;; --------------------------------------------------
;; Font
;; --------------------------------------------------

;; English
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 300) ; font, font size

;; Japanese
(set-default-font "VL Gothic-11")


;; --------------------------------------------------
;; Window size
;; --------------------------------------------------
(setq initial-frame-alist '((width . 160) (height . 50) (top . 22)(left . 0)))


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

(blink-cursor-mode 0)


;; --------------------------------------------------
;; Encoding
;; --------------------------------------------------

(set-language-environment "Japanese")
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

(setq-default indent-tabs-mode nil)
(custom-set-variables '(tab-width 4))


;; --------------------------------------------------
;; completion
;; --------------------------------------------------
 
(setq completion-ignore-case t)                  ; dont distinguish characutor case
(setq read-file-name-completion-ignore-case t)   ; dont distinguish characutor case
;; (partial-completion-mode t)                      ; partial complettion


;; --------------------------------------------------
;; paren mode
;; --------------------------------------------------

(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face "black") ; change emphasis color (now "khaki")

;; --------------------------------------------------
;; recentf mode
;; --------------------------------------------------

(recentf-mode t)
(setq recentf-max-menu-items 10)            ; max display
(setq recentf-max-saved-items 3000)         ; max save

;; --------------------------------------------------
;; Save hist mode
;; --------------------------------------------------

(savehist-mode 1)
(setq history-length 3000)


;; --------------------------------------------------
;; Cua mode
;; [reference] http://dev.ariel-networks.com/articles/emacs/part5/
;; --------------------------------------------------

(cua-mode t)
(setq cua-enable-cua-keys nil)

;; --------------------------------------------------
;; Don't use C-x C-c
;; --------------------------------------------------
;; (global-set-key (kbd "C-x C-c") 'anything-for-files)
;; (global-set-key (kbd "C-x C-z") 'anything-for-files)

;; (defalias 'exit 'save-buffers-kill-emacs)

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

(setq x-select-enable-clipboard nil)
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



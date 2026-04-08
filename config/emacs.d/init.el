;;; init.el --- Minimal terminal Emacs config -*- lexical-binding: t; -*-

;; ──────────────────────────────────────────────
;; Startup performance
;; ──────────────────────────────────────────────
(setq gc-cons-threshold (* 50 1000 1000))
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 2 1000 1000))))

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; ──────────────────────────────────────────────
;; Package
;; ──────────────────────────────────────────────
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq package-quickstart t)

(require 'use-package)
(setq use-package-always-ensure t)

;; ──────────────────────────────────────────────
;; UI — terminal first, inherit terminal colors
;; ──────────────────────────────────────────────
(menu-bar-mode -1)
(column-number-mode t)
(global-display-line-numbers-mode t)
(show-paren-mode t)
(setq show-paren-delay 0)
(global-hl-line-mode t)

(setq use-short-answers t)
(setq ring-bell-function 'ignore)

;; ──────────────────────────────────────────────
;; Encoding
;; ──────────────────────────────────────────────
(prefer-coding-system 'utf-8-unix)

;; ──────────────────────────────────────────────
;; No backup / lock files
;; ──────────────────────────────────────────────
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; ──────────────────────────────────────────────
;; Indent
;; ──────────────────────────────────────────────
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; ──────────────────────────────────────────────
;; Completion — built-in
;; ──────────────────────────────────────────────
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

;; Inline completion preview (ghost text)
(global-completion-preview-mode t)

;; Vertical minibuffer completion
(fido-vertical-mode t)

;; ──────────────────────────────────────────────
;; History
;; ──────────────────────────────────────────────
(recentf-mode t)
(setq recentf-max-saved-items 100)
(savehist-mode t)

;; ──────────────────────────────────────────────
;; Misc
;; ──────────────────────────────────────────────
(setq ns-command-modifier 'meta)
(which-key-mode t)
(setq isearch-lazy-count t)

(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; Start server so emacsclient can connect to this instance
(require 'server)
(unless (server-running-p)
  (server-start))

;; ──────────────────────────────────────────────
;; Keybindings (preserved)
;; ──────────────────────────────────────────────

;; Movement
(global-set-key (kbd "C-f") 'forward-word)
(global-set-key (kbd "C-b") 'backward-word)

;; Editing
(global-set-key (kbd "C-h") 'backward-delete-char)
(global-set-key (kbd "C-d") 'copy-region-as-kill)
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-z") 'undo)

;; Comment
(global-set-key (kbd "C-x C-x") 'comment-region)
(global-set-key (kbd "C-x t") 'uncomment-region)

;; Search / Replace
(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "C-c q") 'query-replace)
(global-set-key (kbd "M-g") 'grep)

;; Navigation
(global-set-key (kbd "C-c C-g") 'goto-line)

;; ──────────────────────────────────────────────
;; Tree-sitter — auto-install grammars
;; ──────────────────────────────────────────────
(use-package treesit-auto
  :config
  (setq treesit-auto-install 'prompt)
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; ──────────────────────────────────────────────
;; smartchr
;; ──────────────────────────────────────────────
(use-package smartchr
  :vc (:url "https://github.com/imakado/emacs-smartchr"))

;; ──────────────────────────────────────────────
;; Language: Go (eglot + tree-sitter)
;; ──────────────────────────────────────────────
(defun my/eglot-go-save-hooks ()
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t)
  (add-hook 'before-save-hook
            (lambda ()
              (when (eglot-managed-p)
                (call-interactively 'eglot-code-action-organize-imports)))
            nil t))

(defun my/smartchr-go ()
  (local-set-key (kbd "+") (smartchr '("+" " + " " += " " ++ ")))
  (local-set-key (kbd "-") (smartchr '("-" " - " " -= " " -- ")))
  (local-set-key (kbd "=") (smartchr '("=" " = " " := " " != " " == ")))
  (local-set-key (kbd ";") (smartchr '("; " ";")))
  (local-set-key (kbd ">") (smartchr '(" > " " -> " ">")))
  (local-set-key (kbd "<") (smartchr '(" < " " <- " "<")))
  (local-set-key (kbd "(") (smartchr '("(`!!')" "()`!!'" "(")))
  (local-set-key (kbd "{") (smartchr '("{`!!'}" "{\n`!!'\n}" "{")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "["))))

(add-hook 'go-ts-mode-hook #'eglot-ensure)
(add-hook 'go-ts-mode-hook #'my/eglot-go-save-hooks)
(add-hook 'go-ts-mode-hook #'my/smartchr-go)

;; ──────────────────────────────────────────────
;; Language: Markdown
;; ──────────────────────────────────────────────
(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode))

;; ──────────────────────────────────────────────
;; Language: Terraform / HCL
;; ──────────────────────────────────────────────
(use-package terraform-mode
  :mode ("\\.tf\\'" . terraform-mode))

;; ──────────────────────────────────────────────
;; Language: YAML, TOML, JSON, Dockerfile, Shell
;;   — handled by tree-sitter via treesit-auto
;;   — add use-package blocks here when needed
;; ──────────────────────────────────────────────

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((smartchr :url "https://github.com/imakado/emacs-smartchr"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ==================================================
;; RUST SETTING
;; ==================================================

;; --------------------------------------------------
;; Rust mode 
;; --------------------------------------------------
(require 'rust-mode nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; --------------------------------------------------
;; Rustfmt
;; https://github.com/rust-lang-nursery/rustfmt
;; $ cargo install rustfmt
;; --------------------------------------------------
(add-hook 'rust-mode-hook #'rust-enable-format-on-save)

;; --------------------------------------------------
;; RACER = Rust Auto-Complete-ER.
;; https://github.com/phildawes/racer
;; $ cargo install racer
;; $ git clone https://github.com/rust-lang/rust.git ~/.rust
;; --------------------------------------------------
(require 'racer nil t)

(setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))
(setq racer-rust-src-path (getenv "RUST_SRC_PATH"))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

;; --------------------------------------------------
;; Keybind
;; --------------------------------------------------
(defun rust-keybind ()
  (local-set-key (kbd "\C-c j") #'racer-find-definition) ;; Jump to definition
  (local-set-key (kbd "\C-c b") #'pop-tag-mark)          ;; Back to jump source
  )
(add-hook 'rust-mode-hook 'rust-keybind)


;; --------------------------------------------------
;; smartchr
;; --------------------------------------------------
(require 'smartchr nil t)

(defun smartchr-rust ()
  (local-set-key (kbd "(") (smartchr '("(`!!')" "()`!!'" "(")))
  (local-set-key (kbd "{") (smartchr '("{`!!'}" "{\n`!!'\n}" "{")))
  )

(add-hook 'rust-mode-hook 'smartchr-rust)


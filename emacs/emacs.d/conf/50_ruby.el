;; ==================================================
;; RUBY SETTING
;; ==================================================

;; --------------------------------------------------
;; Open as ruby-mode
;; --------------------------------------------------

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;; --------------------------------------------------
;; ruby-electric.el
;; [description] 括弧などを自動挿入
;; [install] (install-elisp https://raw.github.com/ruby/ruby/trunk/misc/ruby-electric.el)
;; --------------------------------------------------
(require 'ruby-electric nil t)

;; end の自動挿入
;; [reference] https://groups.google.com/forum/?fromgroups#!msg/emacs-on-rails/Cuh_x5eCK_M/KDwjY4K6X1YJ

(defun ruby-insert-end () 
  "Insert \"end\" at point and reindent current line."
  (interactive) 
  (insert "end") 
  (ruby-indent-line t) 
  (end-of-line))

;; --------------------------------------------------
;; ruby-block.el
;; [description] endに対応する行のハイライト
;; [install] (auto-install-from-emacsWiki ruby-block.el)
;; --------------------------------------------------
(require 'ruby-block nil t)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;; --------------------------------------------------
;; inf-ruby.el
;; [description] irbをemacsから利用する
;; [install] (install-elisp https://raw.github.com/ruby/ruby/trunk/misc/inf-ruby.el)
;; --------------------------------------------------

(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(autoload 'inf-ruby-setup-keybindings "inf-ruby" "" t)
(eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode-hook 'inf-ruby-setup-keybindings))


;; --------------------------------------------------
;; rcodetools
;; [description]
;;     xmp: #=>
;; --------------------------------------------------
(require 'rcodetools nil t)
(define-key ruby-mode-map (kbd "\C-c \C-d") 'xmp)


;; --------------------------------------------------
;; smartchr
;; [description]
;; --------------------------------------------------

(require 'smartchr nil t)

(defun smartchr-ruby ()
  (local-set-key (kbd "=") (smartchr '(" = " " == " "=")))
  (local-set-key (kbd "+") (smartchr '(" + " " += " "+")))
  (local-set-key (kbd "-") (smartchr '(" - " " -= " "-")))

  (local-set-key (kbd ">") (smartchr '(" => " ">")))
  
  (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  (local-set-key (kbd "{") (smartchr '("{ `!!' }" "{\n`!!'\n}" "{")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[")))
  )

(add-hook 'ruby-mode-hook 'smartchr-ruby)



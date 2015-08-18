;; ==================================================
;; aspell mode
;; ==================================================

;; brew install --with-lang-en aspell
;; echo 'lang en_US' > ~/.aspell.conf
(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

(global-set-key (kbd "\C-c sp") 'ispell-buffer)

(mapc
 (lambda (hook)
   (add-hook hook 'flyspell-prog-mode))
 '(
   go-mode-hook
   ruby-mode-hook
   ))

(mapc
 (lambda (hook)
   (add-hook hook
             '(lambda () (flyspell-mode 1))))
 '(
   markdown-mode-hook
   ))


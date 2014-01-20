;; ==================================================
;; Undo/Redo
;; ==================================================
(require 'undo-tree nil t) ;; Ctrl+u
(global-undo-tree-mode 1)

;; --------------------------------------------------
;; Remain after emacs is closed
;; --------------------------------------------------
(require 'undohist nil t)
(setq undohist-directory "~/.emacs.d/etc/.cache/undohist")
(undohist-initialize)

;; --------------------------------------------------
;; Keybind
;; --------------------------------------------------
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-z")   'undo) 
(global-set-key (kbd "C-S-z") 'redo) ;; Ctrl+Shift+z










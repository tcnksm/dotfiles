;; ==================================================
;; Undo/Redo
;; ==================================================

(require 'undo-tree nil t)
(global-undo-tree-mode 1)

;; --------------------------------------------------
;; Keybind
;; --------------------------------------------------
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-z")   'undo) 
(global-set-key (kbd "C-S-z") 'redo) ;; Ctrl+Shift+z

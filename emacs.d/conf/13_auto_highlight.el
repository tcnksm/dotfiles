;; ==================================================
;; Auto highlight symbol
;; ==================================================
(require 'auto-highlight-symbol nil t)
(global-auto-highlight-symbol-mode t)

;; --------------------------------------------------
;; Highlight symblo
;; --------------------------------------------------
(require 'highlight-symbol nil t)

(global-set-key (kbd "C-]") 'highlight-symbol-at-point)
(global-set-key (kbd "M-]") 'highlight-symbol-remove-all)














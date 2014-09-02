;; --------------------------------------------------
;; Highlight symbol
;; --------------------------------------------------
(require 'highlight-symbol nil t)

(global-set-key (kbd "C-]") 'highlight-symbol-at-point)
(global-set-key (kbd "M-]") 'highlight-symbol-remove-all)

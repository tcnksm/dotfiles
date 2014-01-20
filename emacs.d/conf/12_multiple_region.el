;; ==================================================
;; Multiple-cursors
;; ==================================================
(require 'multiple-cursors nil t)

(global-set-key (kbd "M-j") 'mc/edit-lines)

(require 'smartrep nil t)
(smartrep-define-key
 global-map "C-c" '(("C-n" . 'mc/mark-next-like-this)
                    ("C-p" . 'mc/mark-previous-like-this)
                    ("C-c" . 'mc/mark-all-like-this)))

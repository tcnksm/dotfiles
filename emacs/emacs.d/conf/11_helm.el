;; ==================================================
;; helm.el
;; ==================================================

(require 'helm-config)
(helm-mode 1)

;; -------------------------------------------------
;; Keybind
;; -------------------------------------------------
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list) ;; C-x b is also


;; ==================================================
;; helm.el
;; ==================================================
(require 'helm-config)
(helm-mode 1)

;; -------------------------------------------------
;; Keybind (run)
;; -------------------------------------------------
(global-set-key (kbd "M-y")     'helm-show-kill-ring)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list) ;; C-x b is also
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x C-z") 'helm-resume)
(global-set-key (kbd "C-x C-g") 'helm-do-ag)
(global-set-key (kbd "C-x C-a") 'helm-do-ag)
(global-set-key (kbd "C-c C-s") 'helm-ghq)

;; -------------------------------------------------
;; Keybind (while executing helm)
;; -------------------------------------------------
(define-key helm-read-file-map  (kbd "C-h") 'delete-backward-char)
(define-key helm-read-file-map  (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map  (kbd "C-f") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

;; -------------------------------------------------
;; Occur
;; -------------------------------------------------
(global-set-key (kbd "C-x C-o")          'helm-occur)
(define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)

;; -------------------------------------------------
;; Etc
;; -------------------------------------------------
(setq helm-ff-auto-update-initial-value nil)
(add-to-list 'helm-for-files-preferred-list 'helm-source-ghq)

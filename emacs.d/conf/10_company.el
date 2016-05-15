;; ==================================================
;; company
;; ==================================================
(require 'company nil t)
(global-company-mode t)

;; --------------------------------------------------
;; General settings
;; --------------------------------------------------
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)

;; --------------------------------------------------
;; Keybind at showing candidates
;; --------------------------------------------------
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'compan           define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)


;; --------------------------------------------------
;; Color setting
;; --------------------------------------------------
;; (set-face-attribute 'company-tooltip nil
;;                     :foreground "black" :background "lightgrey")
;; (set-face-attribute 'company-tooltip-common nil
;;                     :foreground "black" :background "lightgrey")
;; (set-face-attribute 'company-tooltip-common-selection nil
;;                     :foreground "white" :background "steelblue")
;; (set-face-attribute 'company-tooltip-selection nil
;;                     :foreground "black" :background "steelblue")
;; (set-face-attribute 'company-preview-common nil
;;                     :background nil :foreground "lightgrey" :underline t)
;; (set-face-attribute 'company-scrollbar-fg nil
;;                     :background "orange")
;; (set-face-attribute 'company-scrollbar-bg nil
;;                     :background "gray40")

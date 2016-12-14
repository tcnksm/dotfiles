;; ==================================================
;; GLOBAL KEY BIND SETTING
;; ==================================================

;; Move
(global-set-key "\C-f" 'forward-word)
(global-set-key "\C-b" 'backward-word)

;; Delete backward
(global-set-key "\C-h" 'backward-delete-char)

;; Comment out
(global-set-key "\C-x\C-x" 'comment-region)

(global-set-key "\C-d" 'copy-region-as-kill)
(global-set-key "\C-w" 'kill-region)

;; (global-set-key "\C-xt" 'uncomment-region)
;; Un-comment out

;; Replace once
(global-set-key "\C-cr" 'replace-string)

;; Replace interactively
(global-set-key "\C-cq" 'query-replace)

;; Auto indent
(global-set-key "\C-m" 'newline-and-indent)          

;; New line
(global-set-key "\C-j" 'newline)

;; Move by line number
(global-set-key "\C-c\C-g" 'goto-line)

;; Grep
(global-set-key "\M-g" 'grep)

;; ;; Chnage window
;; (global-set-key "\C-t" 'other-window)



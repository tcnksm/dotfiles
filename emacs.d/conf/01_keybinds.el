;; ==================================================
;; 
;; GLOBAL KEY BIND SETTING
;;
;; [description1]
;;  (define-key キーマップ キーバインド 関数のシンボル)
;;  (global-set-key キーバインド 関数シンボル)
;; 
;; [description2]
;;  検索順序: (1) マイナーモード (モード名-mode-map) (2) current-local-map (3) global-map 
;; ==================================================


;; Delete backward
(global-set-key "\C-h" 'backward-delete-char)

;; Comment out
(global-set-key "\C-x\C-x" 'comment-region)

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
(global-set-key "\M-C-g" 'grep)

;; ;; Chnage window
;; (global-set-key "\C-t" 'other-window)



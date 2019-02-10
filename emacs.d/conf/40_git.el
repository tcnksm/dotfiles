;; --------------------------------------------------
;; git-gutter
;; [description] Gitとして変更された行を色表示
;; --------------------------------------------------
(require 'git-gutter nil t)
(global-git-gutter-mode t)

(global-set-key (kbd "C-c g =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-c g p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-c g n") 'git-gutter:next-hunk)






;; ==================================================
;; GIT settting
;; ==================================================

;; --------------------------------------------------
;; GitHub
;; --------------------------------------------------
(require 'helm-open-github nil t)
(global-set-key (kbd "C-c o f") 'helm-open-github-from-file)
(global-set-key (kbd "C-c o c") 'helm-open-github-from-commit)
(global-set-key (kbd "C-c o i") 'helm-open-github-from-issues)

;; --------------------------------------------------
;; git-gutter
;; [description] Gitとして変更された行を色表示
;; --------------------------------------------------
(require 'git-gutter nil t)
(global-git-gutter-mode t)

;; --------------------------------------------------
;; Keybind
;; --------------------------------------------------
(global-set-key (kbd "C-c g =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-c g p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-c g n") 'git-gutter:next-hunk)






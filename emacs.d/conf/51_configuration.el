;; ==================================================
;; Configuration language
;; ==================================================

;; --------------------------------------------------
;; HCL
;; --------------------------------------------------
(require 'hcl-mode)
(add-to-list 'auto-mode-alist '("\\.tf$" . hcl-mode))

;; --------------------------------------------------
;; Yaml
;; --------------------------------------------------
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("spec" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; --------------------------------------------------
;; Serverspec
;; --------------------------------------------------
(require 'serverspec)
(add-hook 'ruby-mode-hook '(lambda () (serverspec 1)))

;; --------------------------------------------------
;; TOML
;; --------------------------------------------------
(require 'toml-mode)
(add-to-list 'auto-mode-alist '("\\.toml$" . toml-mode))

;; --------------------------------------------------
;; Nginx
;; --------------------------------------------------
(require 'nginx-mode nil)

;; --------------------------------------------------
;; Vagrant
;; --------------------------------------------------
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;; --------------------------------------------------
;; Terraform
;; --------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.tf$" . ruby-mode))

;; --------------------------------------------------
;; Docker
;; --------------------------------------------------
(require 'dockerfile-mode nil)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; --------------------------------------------------
;; Capistrano
;; --------------------------------------------------
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))

;; --------------------------------------------------
;; Guard
;; --------------------------------------------------
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))

;; --------------------------------------------------
;; Chef
;; --------------------------------------------------
(add-to-list 'auto-mode-alist '("Berksfile$" . ruby-mode))

;; --------------------------------------------------
;; Systemd
;; --------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.service$" . conf-mode))

;; ==================================================
;; Configuration language
;; ==================================================

;; --------------------------------------------------
;; HCL
;; --------------------------------------------------
(require 'hcl-mode nil t)

;; --------------------------------------------------
;; Terraform
;; --------------------------------------------------
(require 'terraform-mode nil t)

(defun smartchr-tf ()
  (local-set-key (kbd "{") (smartchr '("{`!!'}" "{\n`!!'\n}" "{")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[")))
  )

(add-hook 'terraform-mode 'smartchr-tf)
(terraform-format-on-save-mode t)

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
;; (require 'serverspec)
;; (add-hook 'ruby-mode-hook '(lambda () (serverspec 1)))

;; --------------------------------------------------
;; TOML
;; --------------------------------------------------
(require 'toml-mode)
(add-to-list 'auto-mode-alist '("\\.toml$" . toml-mode))

;; --------------------------------------------------
;; Jinja2
;; --------------------------------------------------
(require 'jinja2-mode)
(add-to-list 'auto-mode-alist '("\\.jinja$" . jinja2-mode))

;; --------------------------------------------------
;; Nginx
;; --------------------------------------------------
(require 'nginx-mode nil)

;; --------------------------------------------------
;; Vagrant
;; --------------------------------------------------
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

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

;; --------------------------------------------------
;; etc
;; --------------------------------------------------

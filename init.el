(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

(defalias 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)

(setq ansi-color-for-comint-mode t)

(show-paren-mode 1)


;; Packages setup
(require 'package)

(setq package-archives
      '(("melpa"       . "http://melpa.org/packages/")
        ("gnu"         . "http://elpa.gnu.org/packages/")
        ("marmalade"   . "http://marmalade-repo.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


(use-package moe-theme
  :ensure t
  :demand t
  :config (load-theme 'moe-dark t))


(use-package better-defaults
  :ensure t
  :demand t)

(use-package exec-path-from-shell
  :ensure t
  :demand t
  :if (memq window-system '(mac ns))
  :config (exec-path-from-shell-initialize))


(use-package magit
  :ensure t
  :demand t)

(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))


(use-package yas-jit
  :ensure t)


(use-package yaml-mode
  :ensure t)

(use-package pyenv-mode
  :ensure t)

(use-package elpy
  :ensure t
  :init
  (setq elpy-modules (quote (elpy-module-sane-defaults elpy-module-company
                             elpy-module-eldoc elpy-module-flymake
                             elpy-module-pyvenv elpy-module-yasnippet)))
  (setq elpy-rpc-backend "jedi")
  
  :config
  (elpy-enable))

(use-package clojure-mode
  :ensure t)

(use-package paredit
  :ensure t)

(use-package rainbow-delimiters
  :ensure t)

(use-package cider
  :ensure t)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

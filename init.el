
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(prefer-coding-system 'utf-8)



(setq ring-bell-function 'ignore)

(when (memq window-system '(mac ns))
  (setq mac-option-modifier 'super)
  (setq mac-command-modifier 'meta))

(setq
 inhibit-startup-message t

 load-prefer-newer t
 history-length 256
 maximum-scroll-margin 0.1
 scroll-margin 25
 scroll-preserve-screen-position t

 create-lockfiles nil 

 select-enable-clipboard t
 select-enable-primary t
 save-interprogram-paste-before-kill t
 mouse-yank-at-point t

 custom-file (expand-file-name "custom.el" user-emacs-directory)
 backup-directory-alist `(("." . ,(concat user-emacs-directory
                                          "backups"))))

(defalias 'yes-or-no-p 'y-or-n-p)

(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org"   . "https://orgmode.org/elpa/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t
      use-package-always-defer t)

(use-package ample-theme
  :demand)

(use-package uniquify
  :init
  (setq uniquify-buffer-name-style 'forward)

  :ensure nil
  :demand)

(use-package saveplace
  :init (save-place-mode)
  :config
  (setq save-place-file (concat user-emacs-directory "places"))
  :ensure nil
  :demand)

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package paren
  :custom
  (show-paren-when-point-inside-paren t)
  (show-paren-when-point-in-periphery t)

  :init
  (setq show-paren-delay 0)
  (show-paren-mode t)

  :demand
  :ensure nil)


(use-package exec-path-from-shell
  :custom
  (exec-path-from-shell-check-startup-files nil)
  :config
  (push "HISTFILE" exec-path-from-shell-variables)
  (exec-path-from-shell-initialize))

(use-package yasnippet
  :init
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets)


(use-package flycheck
  :init
  (global-flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

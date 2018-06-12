(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(setq inhibit-startup-message t)

(setq ring-bell-function 'ignore)

(when (memq window-system '(mac ns))
  (setq mac-option-modifier 'super)
  (setq mac-command-modifier 'meta))

(setq
 x-select-enable-clipboard t
 x-select-enable-primary t
 save-interprogram-paste-before-kill t
 mouse-yank-at-point t

 custom-file (expand-file-name "custom.el" user-emacs-directory)
 save-place-file (concat user-emacs-directory "places")

 backup-directory-alist `(("." . ,(concat user-emacs-directory
                                          "backups"))))

(setq show-paren-delay 0)
(show-paren-mode t)

(defalias 'yes-or-no-p 'y-or-n-p)

(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org"   . "https://orgmode.org/elpa/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

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
  :ensure nil
  :demand)

(use-package magit
  :bind (("C-x g" . magit-status)))

(require 'package)

(setq package-archives
      '(("original"    . "http://tromey.com/elpa/")
        ("gnu"         . "http://elpa.gnu.org/packages/")
        ("marmalade"   . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(setq additional-packages 
    '(magit moe-theme yasnippet yaml-mode))

; fetch the list of packages available 
(when (not package-archive-contents)
  (package-refresh-contents))

; install the missing packages
(dolist (package additional-packages)
  (when (not (package-installed-p package))
    (package-install package)))


(defalias 'yes-or-no-p 'y-or-n-p)

(load-theme 'moe-dark t)

(ido-mode t)
(setq ido-enable-flex-matching t)

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'saveplace)
(setq-default save-place t)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "C-c m") 'magit-status)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

(setq auto-mode-alist
      (append
       '(("Capfile" . ruby-mode)
         ("Rakefile" . ruby-mode)
         ("Gemfile" . ruby-mode)
         ("config.ru'" . ruby-mode))
       auto-mode-alist))

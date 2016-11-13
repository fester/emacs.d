(defalias 'yes-or-no-p 'y-or-n-p)
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;; no startup msg  
(setq inhibit-startup-message t)        ; Disable startup message


(require 'package)

(setq package-archives
      '(("original"    . "http://tromey.com/elpa/")
        ("gnu"         . "http://elpa.gnu.org/packages/")
        ;; ("marmalade"   . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://stable.melpa.org/packages/")
        ("elpy" . "https://jorgenschaefer.github.io/packages/")))

(package-initialize)


(setq additional-packages 
      '(
        better-defaults exec-path-from-shell

        magit
	moe-theme yasnippet yaml-mode yas-jit

	pyenv-mode elpy
	markdown-mode

	clojure-mode cider projectile
	paredit rainbow-delimiters
	))

; fetch the list of packages available 
(when (not package-archive-contents)
  (package-refresh-contents))

; install the missing packages
(dolist (package additional-packages)
  (when (not (package-installed-p package))
    (package-install package)))


(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


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

(package-initialize)
(elpy-enable)

(global-set-key (kbd "C-c m") 'magit-status)

(highlight-indentation-mode -1)

(show-paren-mode 1)

(setq auto-mode-alist
      (append
       '(("Capfile" . ruby-mode)
         ("Rakefile" . ruby-mode)
         ("Gemfile" . ruby-mode)
         ("config.ru'" . ruby-mode))
       auto-mode-alist))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-yasnippet elpy-module-sane-defaults)))
 '(elpy-rpc-backend "jedi")
 '(exec-path-from-shell-check-startup-files nil)
 '(safe-local-variable-values
   (quote
    ((cider-cljs-lein-repl . "(do (dev) (go) (cljs-repl))")
     (cider-refresh-after-fn . "reloaded.repl/resume")
     (cider-refresh-before-fn . "reloaded.repl/suspend")))))

(setq ansi-color-for-comint-mode t)

;; Product of fat fingers syndrome and shitty mbp butterfly keyboard.
(global-unset-key (kbd "C-x C-c"))
(global-set-key (kbd "C-x C-/") 'save-buffers-kill-terminal)


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

(setq-default c-basic-offset 4
			  tab-width 4)

(setq
 inhibit-startup-message t

 load-prefer-newer t
 history-length 256
 maximum-scroll-margin 0.1
 scroll-margin 5
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

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t
      use-package-always-defer t)

(use-package ample-theme
  :demand)

(use-package diminish)
  

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

(use-package ace-window
  :bind (("M-o" . ace-window)))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))

  :custom
  (exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-variables (quote ("PATH" "MANPATH" "HISTFILE")))

  :init
  (exec-path-from-shell-initialize))

(use-package yasnippet
  :defer 5

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


(use-package ivy
  :diminish ivy-mode
  :demand
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d "
	enable-recursive-minibuffers t)
  :bind ("C-c C-r" . 'ivy-resume))


(use-package swiper
  :bind
  ("C-s" . 'swiper))


(use-package counsel
  :config
  :bind (("M-x" . 'counsel-M-x)
	 ("C-x C-f" . 'counsel-find-file)
	 ("<f1> f" . 'counsel-describe-function)
	 ("<f1> v" . 'counsel-describe-variable)
	 ("<f1> l" . 'counsel-find-library)
	 ("<f2> i" . 'counsel-info-lookup-symbol)
	 ("<f2> u" . 'counsel-unicode-char)
	 ("C-c g" . 'counsel-git)
	 ("C-c j" . 'counsel-git-grep)
	 ("C-c a" . 'counsel-ag)
	 ("C-x l" . 'counsel-locate)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))


(defun projectile-artifact (artifact-name)
  (expand-file-name artifact-name
					(concat user-emacs-directory
							(file-name-as-directory "projectiles"))))

(use-package projectile
  :diminish projectile-mode
  :custom
  (projectile-known-projects-file (projectile-artifact "bookmarks"))
  (projectile-cache-file (projectile-artifact "cache"))

  :init
  (projectile-mode))


(use-package which-key
      :diminish which-key-mode
      :config
      (which-key-mode))

(use-package string-inflection
  :bind
  ("C-c s" . 'string-inflection-python-style-cycle))

(use-package flycheck)

;; --------------------
;; C++

(use-package modern-cpp-font-lock
  :config (modern-c++-font-lock-global-mode t))

(use-package company
  :diminish company-mode
  :init
  (global-company-mode))

(use-package company-rtags)

(use-package flycheck-rtags
  :defer t)

(defun setup-flycheck-rtags ()
  (interactive)
  (flycheck-select-checker 'rtags)
  ;; RTags creates more accurate overlays.
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))

(use-package rtags
  :init
  (rtags-enable-standard-keybindings)
  (rtags-diagnostics)
  (setq rtags-completions-enabled t)
  (push 'company-rtags company-backends)
  (require 'flycheck-rtags)

  :bind (:map c-mode-base-map
         ("M-." . rtags-find-symbol-at-point)
         ("M-," . rtags-find-references-at-point)
	 ("<C-tab>" . company-complete)
	 ("M-*" . rtags-location-stack-back))

  :hook (c-mode-common-hook . setup-flycheck-rtags))

(defun set-cmake-ide-build-dirs ()
  (with-eval-after-load 'projectile
	(setq cmake-ide-project-dir (projectile-project-root))
	(setq cmake-ide-build-dir (concat (projectile-project-root) "build"))))
  

(use-package cmake-ide
  :after (projectile rtags)
  :init
  (setq projectile-after-switch-project-hook 'set-cmake-ide-build-dirs)
  
  :config
  (require 'rtags)
  (cmake-ide-setup)

  :bind (:map c-mode-base-map  
			  ("C-c C-c" . cmake-ide-compile)))

(use-package clang-format
  :after projectile
  :bind (:map c-mode-map
	      ("<C-M-tab>" . clang-format-buffer)
         :map c++-mode-map
	      ("<C-M-tab>" . clang-format-buffer)))

;; ---- Python
(use-package elpy
  :init
  (elpy-enable))

(use-package pipenv
   :hook (python-mode . pipenv-mode))


;; ---- Rust
(use-package rust-mode)

(use-package flycheck-rust
  :after rust-mode)

(use-package racer
  :hook
  (rust-mode . racer-mode)
  (racer-mode . flycheck-rust-setup))
  ;; :bind (:map rust-mode-map
  ;; 			  ([tab] . company-indent-or-complete-common)))




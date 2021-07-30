;; TODO:
;; - [x] setup lsp keybindings for go to definition and jump back and ...
;; - [x] smart kill buffer such that it kills the window as well if it is not the last window
;; - [x] ctrl-p replacment for emacs
;; - [ ] setup hydra: https://github.com/abo-abo/hydra
;; - [ ] setup dired
;; - [ ] setup magit
;; src: https://github.com/daviwil/emacs-from-scratch
;; src: https://protesilaos.com/dotemacs/

;; Cheat Sheet:
;; (define-key ...) for creating new key bindings (adding a binding to a keymap/list)
;; (add-hook ...) for adding a function to a hook/list
;; (defun raxjs/funcname () (interactive) ...) for creating new functions that can be called with M-x


;;;;;;;;;; packages ;;;;;;;;;;

(require 'package)
(setq package-enable-at-startup nil)
(setq use-package-verbose nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
	     '("org" . "https://orgmode.org/elpa/")
	     )
(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )

(use-package diminish
  :after use-package
  :ensure t)

;;(use-package inkpot-theme
;;  :ensure t
;;  :config
;;  (load-theme 'inkpot t))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

(use-package doom-modeline
  ;; This package requires the fonts included with all-the-icons to be installed.
  ;; Run M-x all-the-icons-install-fonts to do so
  :ensure t
  :hook (after-init . doom-modeline-mode))

;; --------------------------------------------------------
;; evil
;; C-z to toggle between vim and emacs bindings
(use-package evil
  :diminish
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)
  (setq evil-want-minibuffer t)
  (setq evil-search-module 'evil-search)
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key global-map (kbd "C-x C-u") 'universal-argument)
  (define-key evil-insert-state-map (kbd "C-w") 'evil-window-map)
  (evil-define-key 'insert ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (evil-define-key 'insert ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-mode 1)
  )
;; evil-overriding-maps and evil-intercept-maps variables.

;; pulls in more vim bindings suport for several other modes
(use-package evil-collection
  :ensure t
  :after evil
  :init
  (setq evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init)
  (setq evil-collection-mode-list '(dired))

  ;; fix dired key bindings
  (evil-collection-define-key 'normal 'dired-mode-map "h" 'dired-single-up-directory)
  (evil-collection-define-key 'normal 'dired-mode-map "l" 'dired-single-buffer)
  (evil-collection-define-key 'normal 'dired-mode-map "SPC" 'dired-single-buffer))

(use-package dired-single
  :ensure t
  :after evil-collection)
(use-package dired
  :ensure nil
  :config
  (setq dired-listing-switches "-ahl --group-directories-first"))
  ;; fix evil leader key in dired-mode
  (add-hook 'dired-mode-hook (lambda ()
    (evil-define-key 'normal dired-mode-map (kbd "SPC") 'evil-send-leader)))



;; ivy
(use-package ivy
  :after general
  :diminish
  :ensure t
  :config
  (define-key evil-insert-state-map (kbd "C-j") 'ivy-next-line)
  (define-key evil-insert-state-map (kbd "C-k") 'ivy-previous-line)
  (define-key evil-insert-state-map (kbd "C-l") 'ivy-done)

  (ivy-mode 1))
;; add extera infos for example for counsel-M-x
(use-package ivy-rich
  :ensure t
  :after ivy
  :init
  (ivy-rich-mode 1))

;; counsel some improvments for ivy
(use-package counsel
  :ensure t
  ;;:after ivy
  :diminish
  :config
  (define-key global-map (kbd "M-x") 'counsel-M-x)
  (define-key global-map (kbd "C-x b") 'counsel-switch-buffer)
  (define-key global-map (kbd "C-x C-f") 'counsel-find-file)
  (define-key evil-normal-state-map (kbd "<leader>.") 'counsel-find-file)
  (define-key evil-normal-state-map (kbd "<leader>b") 'counsel-switch-buffer)
  ;;(define-key evil-normal-state-map (kbd "<leader>f") 'counsel-find-file)
  ;;(define-key evil-normal-state-map (kbd "<leader>p") 'counsel-fzf)
  ;;(define-key evil-normal-state-map (kbd "<leader>r") 'counsel-rg)
  (define-key evil-normal-state-map (kbd "<leader>s") 'swiper)

  (defun raxjs/counsel-fzf () (interactive)
	(counsel-fzf nil (raxjs/get-search-root)))
  (defun raxjs/counsel-rg () (interactive)
	(counsel-rg nil (raxjs/get-search-root)))
  (defun raxjs/set-search-root (search-root) (interactive)
	 (setq raxjs/search-root search-root))
  (defun raxjs/get-search-root () (interactive)
	 (if (bound-and-true-p raxjs/search-root)
	     raxjs/search-root
	     default-directory
	     ))

  (define-key evil-normal-state-map (kbd "<leader>r") 'raxjs/counsel-rg)
  ;;(define-key evil-normal-state-map (kbd "<leader>pr") 'counsel-rg)
  (define-key evil-normal-state-map (kbd "<leader>f") 'raxjs/counsel-fzf)
  ;;(define-key evil-normal-state-map (kbd "<leader>pf") 'counsel-fzf)
  (define-key evil-normal-state-map (kbd "<leader>ps") '(lambda
                             () (interactive)
                             (raxjs/set-search-root default-directory)))
  (define-key evil-normal-state-map (kbd "<leader>pu") '(lambda
							 () (interactive)
                                                (raxjs/set-search-root nil)))

  ;;(define-key global-map (kbd "C-c C-r") 'counsel-rg)
  ;;(define-key global-map (kbd "C-c C-f") 'counsel-fzf)



  (setq ivy-initial-inputs-alist nil) ;; no prefixes in ivy searches like "^"
  )


;; projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode t))

;; company (auto compleation)
(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0.0
      company-minimum-prefix-length 3)
  :config
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection)
  (define-key company-active-map (kbd "C-j") 'company-select-next)
  (define-key company-active-map (kbd "C-k") 'company-select-previous)


  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode)
  (add-hook 'python-mode-hook 'company-mode)
  (add-hook 'slime-mode-hook 'company-mode)

    (defface company-tooltip
    '((default :foreground "green")
	(((class color) (min-colors 88) (background light))
	(:background "cornsilk"))
	(((class color) (min-colors 88) (background dark))
	(:background "yellow"))
	(t
	(:background "yellow")))
    "Face used for the tooltip.")



  (company-tng-mode 1)
  (global-company-mode t)
  )
;;(use-package company-box
;;  :ensure t
;;  :config
;;  (add-hook 'company-mode-hook 'company-box-mode))

;; lsp-mode
(use-package lsp-mode
  :ensure t
  :init
  (setq gc-cons-threshold 100000000
      ead-process-output-max (* 1024 1024))
  (setq lsp-prefer-capf t)
  (setq lsp-completion-provider :capf)
  (setq lsp-completion-enable t)
  :config
  (add-hook 'lsp-mode 'lsp-enable-which-key-integration)
  ;;(add-hook 'c++-mode-hook 'lsp-deferred)
  ;;(add-hook 'c-mode-hook 'lsp-deferred)
  (add-hook 'ruby-mode-hook 'lsp-deferred)
  (add-hook 'python-mode-hook 'lsp-deferred)
  (add-hook 'rust-mode-hook 'lsp-deferred)

  (define-key lsp-mode-map (kbd "<tab>") 'company-indent-or-complete-common)
  (define-key lsp-mode-map (kbd "<leader>gd") 'lsp-ui-peek-find-definitions)
  (define-key lsp-mode-map (kbd "<leader>go") 'lsp-ui-peek-jump-backward)
  (define-key lsp-mode-map (kbd "<leader>gr") 'lsp-find-references))

;; ccls
(use-package ccls
  :ensure t
  :init
  (setq ccls-executable "/usr/bin/ccls"))
;; rust
(use-package rust-mode
  :ensure t
  :init
  (setq lsp-rust-server "/usr/bin/rls")
  (setq lsp-rust-analyzer-server-command "/usr/bin/rust-analyzer"))

;; eTAGS
(setq tags-add-tables nil)
(define-key evil-normal-state-map (kbd "<leader>td") 'xref-find-definitions)
(define-key evil-normal-state-map (kbd "<leader>tf") 'xref-find-apropos)
(define-key evil-normal-state-map (kbd "<leader>ts") 'xref-find-references)
(define-key evil-normal-state-map (kbd "<leader>tv") 'visit-tags-table)
(add-hook 'c-mode-hook (lambda ()
			 (xref-etags-mode t)))

;; php
(use-package php-mode
  :ensure t
  :init
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode)))

(use-package swift-mode
  :ensure t
  :init
(add-to-list 'auto-mode-alist '("\\.swift$" . php-mode)))


;; popup help menu with all avilable keys when typing prefix key combo
(use-package which-key
  :ensure t
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq wich-key-idle-delay 0.1))


;; nicer help pages
(use-package helpful
  :ensure t
  :commands (helpfull-callable helpfull-variable helpfull-command helpfull-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package magit
  :ensure t)

(use-package org
  :ensure t
  :config
  (setq org-use-fast-todo-selection t)
  (setq org-adapt-indentation nil)
  (setq electric-indent-mode nil)
  (setq org-src-preserve-indentation nil)
  (setq org-edit-src-content-indentation 0)
  ;; (org-indent-mode)
  (setq org-agenda-files '(
			 "~/s/org/"
			 ))
  (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "DONE(d)")))
  (setq org-return-follows-link t) ;; follow links with RET

  ;; load some functions from doom emacs
  (load (concat user-emacs-directory "doom-stuff.el"))
  ;; remap some keys
  (add-hook 'org-mode-hook (lambda ()
(define-key org-mode-map [remap org-insert-heading-respect-content] '+org/insert-item-below)))

  ;; some custom stuff
  (setq raxjs/org-dir (expand-file-name "~/org"))

  (define-key evil-normal-state-map (kbd "<leader>np")
    '(lambda () (interactive) (counsel-fzf nil raxjs/org-dir "org-notes: ")))
  (define-key evil-normal-state-map (kbd "<leader>nf")
    '(lambda () (interactive) (counsel-find-file raxjs/org-dir)))
  (define-key evil-normal-state-map (kbd "<leader>nc") 'org-capture)
  (define-key global-map (kbd "C-c l") 'org-store-link)
  (define-key global-map (kbd "C-c C-l") 'org-insert-link)
  (define-key evil-normal-state-map (kbd "C-c C-l") 'org-insert-link)

  ;; capture templates
  (setq org-capture-templates
	(quote (("t" "task" entry (file "~/org/refile.org") "* TODO %?\n")
		)))

  ;; This is needed as of Org 9.2
  (require 'org-tempo)
  (setq org-structure-template-alist '(
             ("p" . "src python")
	     ("s" . "src shell :results output replace")
	     ("t" . "src text")
	     ("x" . "src xml")
	     ("j" . "src json")
	     ("d" . "src diff")
	     ("l" . "src emacs-lisp")
	     ("r" . "src rust")
	     ("c" . "src c")
	     ))

  ;; get C-c C-c working in code blocks
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (shell . t)
     (ruby . t)
     (dot . t)
     (C . t)
     (gnuplot . t)
     (haskell . t)
     )
   )
   (setq org-confirm-babel-evaluate nil)
  ) ;; end of org use-package

(use-package org-bullets
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-bullets-bullet-list '("❶" "❷" "❸" "❹" "❺" "❻" "❼" "❽" "❾" "❿"))
)

(use-package ob-async
  :ensure t)

;;;; vterm
;;(use-package vterm
;;  :ensure t
;;  :config
;;  (define-key evil-normal-state-map (kbd "<leader>ot") 'vterm)
;;  )


;;;; recursive search packages
;;(use-package deadgrep
;;  :ensure t
;;  :config
;;  (define-key global-map (kbd "C-c C-r") 'deadgrep)
;;  )

;; maybe hydra could be usefull its like i3 modes

;; --------------------------------------------------------

;; some settings

;; basic stuff
(defalias 'yes-or-no-p 'y-or-n-p)
(setq scroll-conservatively 100)
(setq ring-bell-function 'ignore)
(global-auto-revert-mode t)
(setq auto-revert-verbose nil)
(show-paren-mode 1)
(electric-indent-mode 1)
;;(global-whitespace-mode t)
(global-so-long-mode t)

;; modeline lines and columns (L,C)
(line-number-mode 1)
(column-number-mode 1)

;; no startup message screen
(setq inhibit-startup-message t)

;; no gui stuff
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
;;(set-fringe-mode 10) ;; not sure what this is so don't use it
(menu-bar-mode -1)


;; theme
;;(load-theme 'deeper-blue)

;; backup files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil)  ; stop creating .# files


;; enable disabled functions
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;; stop asking to follow symlinks to vc files
(setq vc-follow-symlinks t)

;; hl line mode
;;(global-hl-line-mode t)



;; -----------------------------------------------------------------

;; some key bindings

;; c-g = esc
(define-key global-map (kbd "<escape>") 'keyboard-escape-quit)

;; ibuffer
(define-key global-map (kbd "C-x C-b") 'ibuffer)

;; always kill current buffer and window if not the last
(defun raxjs/kill-curr-buffer ()
  (interactive)
  ;;  (kill-buffer-and-window)
  (kill-buffer (current-buffer))
  (if (< 1 (count-windows)) (delete-window) nil))
(global-set-key (kbd "C-x k") 'raxjs/kill-curr-buffer)




;; fix SSH_AUTH_SOCK
(defun raxjs/get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))
(defun raxjs/trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
(replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))
(setenv "SSH_AUTH_SOCK" (raxjs/trim-string (raxjs/get-string-from-file "/tmp/emacs_auth_sock")))
(getenv "SSH_AUTH_SOCK")


;; email
(setq email-config (expand-file-name "~/.emacs.d/email.el"))
(when (file-exists-p email-config)
  (load email-config))



;;;; lisp setup ;;;;
;;
;; wget https://beta.quicklisp.org/quicklisp.lisp
;; sbcl --load quicklisp.lisp
;; (quicklisp-quickstart:install)
;; (ql:add-to-init-file)
;; (ql:quickload "quicklisp-slime-helper")
(when (file-exists-p "~/quicklisp/slime-helper.el")
    (load (expand-file-name "~/quicklisp/slime-helper.el"))
    (setq inferior-lisp-program "sbcl"
	  slime-complete-symbol-function 'slime-fuzzy-complete-symbol
	  )

    (use-package slime-company
	:ensure t
	:after (slime company)
	:config
	(setq slime-company-completion 'fuzzy
	      slime-company-after-completion 'slime-company-just-one-space
	      )
	(slime-setup '(slime-fancy slime-company))
	)
    )

;;;; clojure setup
;;
;;(use-package clojure-mode
;;  :ensure t)
;;
;;(use-package cider
;;  :ensure t)
;;
;;(use-package symex
;;  :ensure t
;;  :config
;;  (setq symex--user-evil-keyspec
;;  ;; must be defined bofore symex-initialize
;;	'(("h" . symex-go-down)
;;	  ("j" . symex-go-forward)
;;	  ("k" . symex-go-backward)
;;	  ("l" . symex-go-up)
;;	  ("t" . symex-mode-interface)
;;	  ))
;;  (symex-initialize)
;;  (define-key evil-normal-state-map (kbd "t") 'symex-mode-interface)
;;  (symex--toggle-highlight)
;;  :custom
;;  (symex-modal-backend 'evil)
;;  (symex-remember-branch-position-p nil))

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :config
  (flymake-mode-off)
  ;;(setq python-shell-interpreter "jupyter"
  ;;	python-shell-interpreter-args "console --simple-prompt"
  ;;	python-shell-prompt-detect-failure-warning nil)
  (setenv "WORKON_HOME" "~/.pyenv/versions/")
  ;;(add-to-list 'python-shell-completion-native-disabled-interpreters
  ;;	       "jupyter")
  (define-key elpy-mode-map (kbd "C-c C-c") 'elpy-shell-send-buffer)
  (define-key elpy-mode-map (kbd "C-x C-e") 'elpy-shell-send-statement)
  )
;; use pyenv-mode-set to set the virtualenv
(use-package pyenv-mode
  :ensure t)

;; misc
(defun raxjs/display-startup-time ()
  (message "Emacs loaded in %s with %d  garbage collections."
	   (format "%.2f seconds"
		   (float-time
		    (time-subtract after-init-time before-init-time)))
	   gcs-done))
(add-hook 'emacs-startup-hook #'raxjs/display-startup-time)


;;(use-package idle-highlight-mode
;;  :ensure t
;;  :config
;;  (setq idle-highlight-idle-time 0.1)
;;  (add-hook 'prog-mode-hook (lambda ()
;;			      (idle-highlight-mode t))))

(use-package hi-lock
  :ensure nil
  :config
(set-face-background 'hi-yellow   "#ebdc8a")
(set-face-foreground 'hi-yellow   "#403d31")
(set-face-background 'hi-pink     "#c15dcf")
(set-face-foreground 'hi-pink     "#1e181f")
(set-face-background 'hi-green    "#68d164")
(set-face-foreground 'hi-green    "#131f13")
(set-face-background 'hi-blue     "#4070de")
(set-face-foreground 'hi-blue     "#d1d7e3"))

(define-key evil-normal-state-map (kbd "<leader>hs") 'highlight-symbol-at-point)
(define-key evil-normal-state-map (kbd "<leader>hx") (lambda ()
						       (interactive)
						       (unhighlight-regexp t)))

;; -----------------------------------------------------------------

;; keep my config clean
(setq custom-file (concat user-emacs-directory "/custom.el"))


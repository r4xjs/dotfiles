;;;;;;;;;; packages ;;;;;;;;;;

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )

;; which key
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; swiper
(use-package swiper
  :ensure t
  )

;; popup-kill-ring
(use-package popup-kill-ring
  :ensure t
  )

;; company (auto compleation)
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

;; org-bullets
(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(setq org-bullets-bullet-list '(
			       "❶"
			       "❷"
			       "❸"
			       "❹"
			       "❺"
			       "❻"
			       "❼"
			       "❽"
			       "❾"
			       "❿"
			       ))

;; magit
(use-package magit
  :ensure t)

;; sane-term
(use-package sane-term
  :ensure t
  )

;; ido-vertical-mode
(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; smex
(use-package smex
  :ensure t
  :init
  (smex-initialize)
  )

;; projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode t))

;; undo-tree
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode t))

;; expand-region keybinding
(use-package expand-region
  :ensure t)

;; counsel: package for some fuzzy search things
(use-package counsel
  :ensure t)

;; theme
(use-package afternoon-theme
  :ensure t)




;;;;;;;;;; settings ;;;;;;;;;;


;; basic stuff
(defalias 'yes-or-no-p 'y-or-n-p)
(setq scroll-conservatively 100)
(setq ring-bell-function 'ignore)
(global-auto-revert-mode t)
(setq auto-revert-verbose nil)

;; backup files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil)  ; stop creating .# files

;; use i3 for window management C-x 5 b for new frame
;; (setq pop-up-frames nil)
;; (setq pop-up-windows nil)
;; (setq iswitchb-default-method 'samewindow) 
;; (setq ido-default-buffer-method 'samewindow)

;; some modes
(setq cua-rectangle-mark-key (kbd "C-c v v"))
(setq save-interprogram-paste-before-kill t)
(cua-mode t)
(setq show-paren-when-point-inside-paren nil)
(show-paren-mode t)

;; Disable some minor modes
(auto-save-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; clock in mode line
(setq display-time-24hr-format t)
(display-time-mode 1)

;; modeline lines and columns (L,C)
(line-number-mode 1)
(column-number-mode 1)

;; default ansi-term shell is zsh
(defvar my-term-shell "/usr/bin/zsh")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

;; ido
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)







;;;;;;;;;; custom functions ;;;;;;;;;;


;; always kill current buffer
(defun kill-curr-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

;; open-line-below/above
(defun raxjs/open-line-below ()
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))
(defun raxjs/open-line-above ()
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (previous-line))

;; highlighting keybidnings
(defun raxjs/unhighlight-all ()
  (interactive)
  (unhighlight-regexp t)
  )







;;;;;;;;;; key bindings ;;;;;;;;;;

;; better key bindings for end-of-buffer and beginning-of-buffer
(global-set-key (kbd "C-c g g") 'beginning-of-buffer)
(global-set-key (kbd "C-c G") 'end-of-buffer)

;; marking bindings
(global-set-key (kbd "C-c m p") 'er/mark-paragraph)
(global-set-key (kbd "C-c m w") 'er/mark-word)
(global-set-key (kbd "C-c m \"") 'er/mark-inside-quotes)
(global-set-key (kbd "C-c m (") 'er/mark-inside-pairs)
(global-set-key (kbd "C-c m )") 'er/mark-inside-pairs)
(global-set-key (kbd "C-c m s") 'er/mark-symbol)

;; highlight bindings
(global-set-key (kbd "C-c h h") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c h u") 'unhighlight-regexp)
(global-set-key (kbd "C-c h U") 'raxjs/unhighlight-all)

;; open line below/above bindings
(global-set-key (kbd "C-o") 'raxjs/open-line-below)
(global-set-key (kbd "C-S-o") 'raxjs/open-line-above)

;; page up and page down better keybindings
(global-set-key (kbd "C-c n") 'cua-scroll-up)
(global-set-key (kbd "C-c p") 'cua-scroll-down)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; always kill current buffer
(global-set-key (kbd "C-x k") 'kill-curr-buffer)

;; ido switch buffer binding
(global-set-key (kbd "C-x b") 'ido-switch-buffer)

;; search bindings
(global-set-key (kbd "C-s") 'isearch-forward)
(global-set-key (kbd "M-s") 'swiper)

;; window movments
(define-prefix-command 'window-prefix-map)
(global-set-key (kbd "C-w") 'window-prefix-map)
(define-key window-prefix-map (kbd "f") 'windmove-right)
(define-key window-prefix-map (kbd "b") 'windmove-left)
(define-key window-prefix-map (kbd "n") 'windmove-down)
(define-key window-prefix-map (kbd "p") 'windmove-up)
(define-key window-prefix-map (kbd "1") 'delete-other-windows)
(define-key window-prefix-map (kbd "2") 'split-window-below)
(define-key window-prefix-map (kbd "3") 'split-window-right)
(define-key window-prefix-map (kbd "0") 'delete-window)
(define-key window-prefix-map (kbd "a") 'ivy-push-view)
(define-key window-prefix-map (kbd "s") 'ivy-switch-view)

;; popup kill ring binding :not-working: shadowed by delete-selection-repeat-replace-region
;; (global-set-key (kbd "M-v") 'popup-kill-ring)
(global-set-key (kbd "M-y") 'popup-kill-ring)

;; counsel fuzzy search bindings
(define-key shell-mode-map (kbd "C-r") 'counsel-shell-history)
(global-set-key (kbd "C-x C-p") 'counsel-fzf)

;; sane-term bindings
(global-set-key  (kbd "C-c t") 'sane-term)
(global-set-key (kbd "C-c T") 'sane-term-create)

;; smex meta x binding
(global-set-key  (kbd "M-x") 'smex)

;; org-mode custom key bindings
(defun raxjs/org-mode-keys ()
  (interactive)
  (define-key (current-local-map) (kbd "C-c a a") 'org-agenda-list)
  (define-key (current-local-map) (kbd "C-c a t") 'org-todo-list)
  )
(add-hook 'org-mode-hook 'raxjs/org-mode-keys)






;;;;;;;;;; shell stuff ;;;;;;;;;;

(setenv "PAGER" "")


;;;;;;;;;; do not edit ;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#080808" "#d70000" "#67b11d" "#875f00" "#268bd2" "#af00df" "#00ffff" "#b2b2b2"])
 '(custom-enabled-themes nil)
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f"))))
 '(org-agenda-files (quote ("~/todo.org")))
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "ADBO" :family "Source Code Pro")))))
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

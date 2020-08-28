
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; melpa source
(setq packages-archives
      '(("melpa" . "https://melpa.org/packages/")))

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 16))

;; set font size
(set-face-attribute 'default nil :height 100)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


;; theme
(load-theme 'afternoon t)

;; always kill current buffer and window if not the last
(defun raxjs/kill-curr-buffer ()
  (interactive)
  ;;  (kill-buffer-and-window)
  (kill-buffer (current-buffer))
  )
(global-set-key (kbd "C-x k") 'raxjs/kill-curr-buffer)

;; dired
;;(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(defun raxjs/dired-back ()
  (interactive)
  ;;(dired-up-directory)
  (find-alternate-file "..")
  )
(defun raxjs/dired-open ()
  (interactive)
    (if (file-directory-p (dired-get-file-for-visit))
      (dired-find-alternate-file)
      (dired-find-file)))
(map! :map dired-mode-map :n "C-h" #'raxjs/dired-back)
(map! :map dired-mode-map :n "C-l" #'raxjs/dired-open)

(setq dired-async-mode t)
(setq dired-hide-details-mode t)
;(map! :map dired-mode-map :n "RET" #'dired-find-file)
;(map! :map dired-mode-map :n "l" #'dired-find-alternate-file)


;; ido
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)


;; fight slowdown
(setq display-line-numbers-type nil)
(set-default 'truncate-lines t)
(after! org
  (setq org-startup-folded t)
  )


;;;;;;; evil fixes ;;;;;;;

;; disable evil-ex-search-backward
(defun raxjs/test1 ()
  (interactive)
  )
(map! :n "?" 'raxjs/test1)
;; remap C-u back to normal
(map! :v "C-u" #'universal-argument)





;; remap find-file
(map! :leader :n "." #'counsel-find-file)

;; add new org agenda file
(map! :leader :n "oaA" #'org-agenda-file-to-front)


;;(defmacro map! (&rest rest)
;;  "A convenience macro for defining keybinds, powered by `general'.
;;
;;If evil isn't loaded, evil-specific bindings are ignored.
;;
;;States
;;  :n  normal
;;  :v  visual
;;  :i  insert
;;  :e  emacs
;;  :o  operator
;;  :m  motion
;;  :r  replace
;;  :g  global  (binds the key without evil `current-global-map')
;;
;;  These can be combined in any order, e.g. :nvi will apply to normal, visual and
;;  insert mode. The state resets after the following key=>def pair. If states are
;;  omitted the keybind will be global (no emacs state; this is different from
;;  evil's Emacs state and will work in the absence of `evil-mode').
;;
;;Properties
;;  :leader [...]                   an alias for (:prefix doom-leader-key ...)
;;  :localleader [...]              bind to localleader; requires a keymap
;;  :mode [MODE(s)] [...]           inner keybinds are applied to major MODE(s)
;;  :map [KEYMAP(s)] [...]          inner keybinds are applied to KEYMAP(S)
;;  :prefix [PREFIX] [...]          set keybind prefix for following keys. PREFIX
;;                                  can be a cons cell: (PREFIX . DESCRIPTION)
;;  :prefix-map [PREFIX] [...]      same as :prefix, but defines a prefix keymap
;;                                  where the following keys will be bound. DO NOT
;;                                  USE THIS IN YOUR PRIVATE CONFIG.
;;  :after [FEATURE] [...]          apply keybinds when [FEATURE] loads
;;  :textobj KEY INNER-FN OUTER-FN  define a text object keybind pair
;;  :when [CONDITION] [...]
;;  :unless [CONDITION] [...]
;;
;;  Any of the above properties may be nested, so that they only apply to a
;;  certain group of keybinds."


;; fix SSH_AUTH_SOCK
(defun raxjs/get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))
(defun raxjs/trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
(replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string))
)

(setenv "SSH_AUTH_SOCK" (raxjs/trim-string (raxjs/get-string-from-file "/tmp/emacs_auth_sock")))
(getenv "SSH_AUTH_SOCK")


;; org to markdown with pandoc
(defun raxjs/org-to-md ()
    "Convert selected org region to markdown with pandoc"
    (interactive)
(let (  (b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region
     b e "pandoc --from org --to gfm"
     )
    )
)
(map! :leader :v "mm" #'raxjs/org-to-md)

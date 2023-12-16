;; On Windows put init.el into %APPDATA%\.emacs.d\ (which is C:\Users\<username>\AppData\Roaming\.emacs.d\ by default)


;; TODO
;; - goto last cursor position (forward backward)
;; - the <package-name>-autoloads.el files in elpa directory have weird encodings and produce errors.
;;   We need to bulk convert them to unix lf. Currently we can run the following command in a git bash:
;;     find . -name "*.el" -exec dos2unix {} \;
;;   later we may want to automate this
;; - implement search like it would work in modern software.
;;    package ctrlf already does most of the things but is not quite there yet and needs some tweaking
;;   - center on selection when doing `ctrlf-next-match` and `ctrlf-previous-match`
;;   - f3 resumes previous search if search was not active before and jumps to the next match
;;   - ctrl-f starts new search (without jumping to the next match).
;;     it either uses current selection or symbol under cursor or last search
;; - switch to left/right window should create a new window if it does not exist
;; - toggle between bottom top window (like terminal or minibuffer)





;;//////////////////////////////////////////////////////////////////////////////////////////////////
;; Better emacs defaults

;; By default Emacs triggers garbage collection at ~0.8MB which makes
;; startup really slow. Since most systems have at least 256MB of memory,
;; we increase it during initialization.
(setq gc-cons-threshold 256000000)
(add-hook 'after-init-hook #'(lambda ()
                               ;; restore after startup
                               (setq gc-cons-threshold 8000000))
)

(setq inhibit-startup-message t) ; No splash
(scroll-bar-mode -1)             ; No scrollbar
(tool-bar-mode -1)               ; No toolbar
(tooltip-mode -1)                ; No tooltips
(menu-bar-mode -1)               ; No menu bar
(fringe-mode -1)                 ; Remove fringes on the side of the window
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ; Start emacs maximized


(setq visible-bell t) ; Visual bell instead of loud exclamation beep when i.e. pressing arrow up at beginning of a file

(set-face-attribute 'default nil :font "Hack" :height 140) ; Change default font style and size

;; Show line and column numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes (TODO enable fringe mode 10 here)
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda() ((display-line-numbers-mode 0)
			    (set-fringe-mode 5) ; Leaves a little space around the buffer
			    ))))

;; Automatically save and restore sessions on startup
(desktop-save-mode 1)

;; Show trailing whitespace and EOF
(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)
;; Remove trailing white space upon saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Don't ask for confirmation when opening symlinked file
(setq vc-follow-symlinks t )

;; Write auto-saves and backups to separate directory
(make-directory "~/.tmp/emacs/auto-save/" t)
(setq auto-save-file-name-transforms '((".*" "~/.tmp/emacs/auto-save/" t)))
(setq backup-directory-alist '(("." . "~/.tmp/emacs/backup/")))

;; Do not move the current file while creating backup
(setq backup-by-copying t)

;; Disable lockfiles
(setq create-lockfiles nil)

;; Use utf-8 by default
(setq coding-system-for-read 'utf-8 )
(setq coding-system-for-write 'utf-8 )

;; Consider a period followed by a single space to be end of sentence.
(setq sentence-end-double-space nil)

;; Toggle wrapping text at the 100th character
(setq default-fill-column 100)

;; Print a default message in the empty scratch buffer opened at startup
(setq initial-scratch-message "Ok lets goooo :3")

;; Lazy people like me never want to type "yes" when "y" will suffice
(fset 'yes-or-no-p 'y-or-n-p)

;; Write customizations to a separate file instead of this file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror 'nomessage)

;; Highlight the line we are currently on
(global-hl-line-mode t)

;; Scrolling
(setq mouse-wheel-scroll-amount '(5 ((shift) . 5))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil)            ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                  ;; scroll window under mouse
(setq scroll-step 1)                                ;; keyboard scroll one line at a time

;; Overwrite selected region (when in insert mode)
(delete-selection-mode t)

;; Change tab key behavior to insert spaces instead
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;; Keep track of recent files
(recentf-mode 1)

;; Keep track of entered minibuffer commands (use M-p to use previous history)
(setq history-length 25)
(savehist-mode 1)

;; Remember and restore the last cursor location of opened files
(save-place-mode 1)

;; Automatically look for changes on disk for open buffers and refresh contents if something has changed
(global-auto-revert-mode 1)


;;//////////////////////////////////////////////////////////////////////////////////////////////////
;; Basic movement and editing

;; Use f-e-d to open the dotfile
(defun find-user-init-file ()
  "Opens the ‘user-init-file’, in another window."
  (interactive)
  (find-file user-init-file)
)

;; Parenthesis matching
(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode +1)
(setq show-paren-delay 0)


;;//////////////////////////////////////////////////////////////////////////////////////////////////
;; Initialize package manager

(require 'package)
;; The following lines tell emacs where to look for new packages
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org"   . "https://orgmode.org/elpa/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Make sure package archive is initialized on fresh installs
(unless package-archive-contents
  (package-refresh-contents))

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; Unless it is already installed
  (package-install 'use-package))          ; Install the most recent version of use-package

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)   ; Makes it so that `use-package` always implicitly uses :ensure t
(setq package-enable-at-startup nil) ; Tells emacs not to load any packages before starting up

;;//////////////////////////////////////////////////////////////////////////////////////////////////
;; UI

;(use-package monokai-theme
;  :config
;  (load-theme 'monokai t))

;; Doom themes have good integration into other packages like magit and filetrees
(use-package doom-themes
  :config
  (load-theme 'doom-dracula t))

;; More modern and less cluttered modeline at the bottom of the screen
(use-package doom-modeline
  :config (doom-modeline-mode 1))

;; Icons for mode line and other things
;; NOTE: The first time we load this config on a new machine, we need to run the following command interactively:
;; M-x nerd-icons-install-fonts
;; After that we need to install the fonts on our system
(use-package nerd-icons)

;; Fill column indicator
(use-package fill-column-indicator :ensure t
  :config
    (add-hook 'prog-mode-hook 'fci-mode)
    (setq-default fill-column 100))

;; Colorful parenthesis matching
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;;//////////////////////////////////////////////////////////////////////////////////////////////////
;; Editing / Keybinding

;; A more easy/straightforward way of defining key bindings
(use-package general)

;; Easy/good undo functionality
(use-package undo-fu)

(setq evil-want-keybinding nil) ; We use evil-collection package instead
(use-package evil
  :init
  (setq evil-undo-system 'undo-fu)
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)    ; Don't use Emacs prefix argument feature
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  ;; Visual line navigation
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; Good defaults for vim keybindings in various modes and packages (i.e. magit)
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Searching with Ctrl-F like in other modern software
(use-package ctrlf)
(ctrlf-mode +1)


;; Generally improved searching and Emacs navigation packages
(use-package ivy
  :diminish (ivy-mode . "") ; Hides the 'ivy' in the minor-mode list in the mode line at bottom
  :bind (
    :map ivy-minibuffer-map
	("TAB" . ivy-alt-done)
	("C-l" . ivy-alt-done)
	("C-j" . ivy-next-line)
	("C-k" . ivy-previous-line)
	:map ivy-switch-buffer-map
	("C-k" . ivy-previous-line)
	("C-l" . ivy-alt-done)
	("C-d" . ivy-switch-buffer-kill)
	:map ivy-reverse-i-search-map
	("C-k" . ivy-previous-line)
	("C-d" . ivy-reverse-i-search-kill))
  :config
    (ivy-mode 1))
(use-package swiper)
(use-package counsel
  :bind
  (("M-x"     . counsel-M-x))
  :config
    (setq ivy-initial-inputs-alist nil)) ; Don't start searches with ^

;; Show more descriptions for when running commands, switching buffers, installing packages etc.
(use-package ivy-rich
  :config (ivy-rich-mode 1))

;; Shows help files with keybindings, current variable values, keyword highlighting, links and additional information like source code snippets and location
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command]  . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key]      . helpful-key))

;; After typing a key command this shows us a list of possible followup key commands
(use-package which-key
  :diminish which-key-mode ; Don't show up as minor mode in the modeline
  :init
  (setq which-key-idle-delay 0.0)
  :config
  (which-key-mode))

(use-package projectile
  :diminish projectile-mode
  :init
  (when (file-directory-p "D:/Creating")
    (setq projectile-project-search-path '("D:/Creating")))
  (setq projectile-switch-project-action #'projectile-dired)
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; Common Lisp development
;; NOTE: This assumes "sbcl" to be in $PATH
;; Start a REPL with `M-x sly`
(use-package sly)
(setq inferior-lisp-program "sbcl")
;; More sane previous input repeating
(general-define-key
 :keymaps 'sly-mrepl-mode-map
 :states '(normal insert visual emacs org)
 "<M-up>" 'sly-mrepl-previous-input-or-button
 "<M-down>" 'sly-mrepl-next-input-or-button)

(general-create-definer kerskuchen/leader-keys
  :keymaps '(normal)
  :prefix "SPC"
  :global-prefix "C-SPC")

(kerskuchen/leader-keys
  :keymaps '(normal insert visual emacs sly-editing-mode-map)
  "t"  '(:ignore t :which-key "toggles")
  "tt" '(counsel-load-theme :which-key "choose theme")

  "f"  '(:ignore f :which-key "file")
  "fr" '(recentf-open-files :which-key "recent")
  "fs" '(save-buffer :which-key "save")
  "fx" '(kill-this-buffer :which-key "close")
  "fn" '(next-buffer :which-key "next")
  "fb" '(previous-buffer :which-key "previous")
  "fi" '(find-user-init-file :which-key "init.el")
  "ff" '(counsel-find-file :which-key "find")

  "e"  '(:ignore e :which-key "evaluate")
  "ef" '(eval-defun :which-key "defun")
  "ee" '(eval-last-sexp :which-key "last expression")
  "eb" '(eval-buffer :which-key "buffer")
  "er" '(eval-region :which-key "region")
  "ei" '(eval :which-key "interactive")
)

(kerskuchen/leader-keys
  :keymaps '(normal insert visual emacs sly-editing-mode-map)
  "c"  '(:ignore c :which-key "compile")
  "cc" '(sly-compile-defun :which-key "defun")
  "cf" '(sly-compile-file :which-key "file")
  "cl" '(sly-compile-and-load-file :which-key "load file")
  "cr" '(sly-compile-region :which-key "region")
  "ce" '(sly-eval-defun :which-key "eval defun")
)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "<C-tab>") 'switch-to-next-buffer)

;; Use more well known program key shortcuts (copy, paste, cut)
(general-define-key
 :states '(insert emacs)
 "C-c" 'evil-yank
 "\C-v" 'evil-paste-after
 "C-x" 'kill
)

;; Fix ALT + arrow keys inside screen/tmux
(define-key input-decode-map "\e[1;3A" [M-up])
(define-key input-decode-map "\e[1;3B" [M-down])
(define-key input-decode-map "\e[1;3C" [M-right])
(define-key input-decode-map "\e[1;3D" [M-left])

(global-set-key [f3] 'ctrlf-next-match)
(global-set-key [(shift f3)] 'ctrlf-previous-match)

(general-define-key

 :states '(normal insert visual emacs org)
 "C-f"  'ctrlf-forward-symbol-at-point

 "C-/"  'comment-or-uncomment-region

 "C-s"  'save-buffer
 "C-w"  'kill-this-buffer
 "M-w"  'kill-this-buffer
 "C-z"  'evil-undo
 "C-y"  'evil-redo
 "M-d"  'evil-scroll-down
 "M-u"  'evil-scroll-up
 "C-+"  'text-scale-increase
 "C--"  'text-scale-decrease

 "M-h" 'previous-buffer
 "M-l" 'next-buffer
 "<M-left>" 'previous-buffer
 "<M-right>" 'next-buffer
 "M-1" 'evil-window-left
 "M-2" 'evil-window-right
 "M-3" 'evil-window-bottom
 "M-4" 'evil-window-top
)

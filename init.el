;;; -*- lexical-binding: t; -*-

(add-to-list 'load-path "~/.emacs.d/scripts/")

;; (require 'elpaca-setup)
(require 'use-package-setup)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(load-theme 'nh-cust-1 t)

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(use-package dashboard
  :init
  (setq initial-buffer-choice 'dashboard-open)
  ;; (setq dashboard-set-heading-icons t)
  ;; (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "NH EMACS!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  ;; (setq dashboard-startup-banner "~/.config/emacs/images/dtmacs-logo.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)))
			  ;; (agenda . 5 )
			  ;; (bookmarks . 3)
			  ;; (projects . 3)
			  ;; (registers . 3)))
  ;; :custom 
  ;; (dashboard-modify-heading-icons '((recents . "file-text")
				      ;; (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(use-package emacs
  :ensure nil
  :config
    (global-display-line-numbers-mode 1)
    (column-number-mode 1)
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1))

(use-package emacs
  :ensure nil
  :config
    (setq display-time-format "%k:%M %Y%m%d" ; format: 24h year month day
          display-time-default-load-average nil))

(use-package diminish)

(use-package smart-mode-line
  :config
  (setq sml/no-confirm-load-theme t)
  (sml/setup)
  (sml/apply-theme 'respectful) ;Respects themes colors
  (setq sml/mode-width 'right
        sml/name-width 60)

  (setq-default mode-line-format
                `("%e"
                  mode-line-front-space
                  evil-mode-line-tage
                  ;;mode-line-mule-info
                  mode-line-client
                  mode-line-modified
                  mode-line-remote
                  mode-line-frame-identification
                  mode-line-buffer-identification
                  sml/pos-id-separator
                  (vc-mode bc-mode)
                  " "
                  ;;mode-line-position
                  mode-line-modes
                  " "
                  mode-line-misc-info)))
;;(smart-mode-line-enable 1)

(use-package rainbow-mode
  :hook
  ((org-mode prog-mode) . rainbow-mode))

(use-package ripgrep)

;; Remap universal argument
(global-set-key (kbd "C-M-u") 'universal-argument)

;; Escape cancels all
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;Unset keys
(global-unset-key (kbd "C-y"))

;; Reset yank
(global-set-key (kbd "C-y") 'yank)

;; General
(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer nh/leader-keys
                          :states '(normal insert visual emacs)
                          :prefix "SPC"
                          :global-prefix "C-SPC")

  (general-create-definer nh/local-leader-keys
                          :states '(normal visual)
                          :keymaps 'override
                          :prefix ","
                          :global-prefix "SPC l")
  (nh/leader-keys
    ":" '(execute-extended-command :which-key "M-x")
    "K" '(kill-emacs :which-key "Kill Emacs")
    "p" '(yank :which-key "Paste/Yank")
    "k" '(kill-region :which-key "Cut")
    "c" '(kill-ring-save :which-key "Copy")
    "s" '(swiper :which-key "Swiper"))

  (nh/leader-keys
    "C" '(:ignore t :which-key "Calc")
    "Cc" '(calc :which-key "Calc")
    "Cg" '(calc-grab-region :which-key "Calc Grab")
    "Cr" '(calc-grab-rectangle :which-key "Calc Grab Rectangle")
    "Cq" '(quick-calc :which-key "Quick Calc")
    "CQ" '(calc-quit :which-key "Quit Calc")
    "Cf" '(full-calc :which-key "Calc Full Screen")
    "Ce" '(calc-embedded :which-key "Calc Embedded"))

  (nh/leader-keys
    "b" '(:ignore t :which-key "Buffer")
    "bn" '(next-buffer :which-key "Next Buffer")
    "bp" '(previous-buffer :which-key "Previous Buffer")
    "br" '(revert-buffer-quick :which-key "Revert Buffer")
    "bR" '(rename-buffer :which-key "Rename Buffer")
    "be" '(eval-buffer :which-key "Eval Buffer")
    "bk" '(kill-current-buffer :wk "kill Current Buffer")
    "bK" '(kill-buffer :wk "Kill Buffer"))
  (nh/leader-keys
    "f" '(:ignore t :which-key "Files")
    "ff" '(find-file :which-key "Find File")
    "fe" '((lambda () (interactive) (find-file "~/.emacs.d/init.org")) :which-key "Open init.org")
    "fi" '((lambda () (interactive) (find-file "~/.emacs.d/init.el")) :which-key "Open init.el"))
 (nh/leader-keys
    "h" '(:ignore t :wk "Help")
    "h a" '(apropos :wk "Apropos")
    "h b" '(describe-bindings :wk "Describe bindings")
    "h c" '(describe-char :wk "Describe character under cursor")
    "h d" '(:ignore t :wk "Emacs documentation")
    "h d a" '(about-emacs :wk "About Emacs")
    "h d d" '(view-emacs-debugging :wk "View Emacs debugging")
    "h d f" '(view-emacs-FAQ :wk "View Emacs FAQ")
    "h d m" '(info-emacs-manual :wk "The Emacs manual")
    "h d n" '(view-emacs-news :wk "View Emacs news")
    "h d o" '(describe-distribution :wk "How to obtain Emacs")
    "h d p" '(view-emacs-problems :wk "View Emacs problems")
    "h d t" '(view-emacs-todo :wk "View Emacs todo")
    "h d w" '(describe-no-warranty :wk "Describe no warranty")
    "h e" '(view-echo-area-messages :wk "View echo area messages")
    "h f" '(describe-function :wk "Describe function")
    "h F" '(describe-face :wk "Describe face")
    "h g" '(describe-gnu-project :wk "Describe GNU Project")
    "h i" '(info :wk "Info")
    "h I" '(describe-input-method :wk "Describe input method")
    "h k" '(describe-key :wk "Describe key")
    "h l" '(view-lossage :wk "Display recent keystrokes and the commands run")
    "h L" '(describe-language-environment :wk "Describe language environment")
    "h m" '(describe-mode :wk "Describe mode")
    "h r" '((lambda () (interactive)
              (load-file "~/.emacs.d/init.el")
                (ignore (elpaca-process-queues)))
              :wk "Reload emacs config")
    "h t" '(load-theme :wk "Load theme")
    "h v" '(describe-variable :wk "Describe variable")
    "h w" '(where-is :wk "Prints keybinding for command if set")
    "h x" '(describe-command :wk "Display full documentation for command")) 
  (nh/leader-keys
    "." '(embark-act :which-key "Embark Act")
    "," '(embark-dwim :which-key "Embark Dwim")
    "B" '(embark-become :which-key "Embark Become")
    "e" '(embark-export :which-key "Embark Export"))
  (nh/local-leader-keys
    :keymaps 'prog-mode-map
    "TAB" '(comment-line :which-key "Comment Line"))
  (nh/local-leader-keys
    :keymaps 'org-mode-map
    "t" '(org-babel-tangle :which-key "Tangle")
    "e" '(org-edit-special :which-key "Edit")
    "l" '(org-lint :which-key "Org Lint"))
  (nh/local-leader-keys
    :keymaps 'org-src-mode-map
    "e" '(org-edit-src-exit :which-key "Exit"))
  (nh/local-leader-keys
    :keymaps 'lisp-mode-map
    "'" '(sly :which-key "Sly")
    ";" '(sly-ask :which-key "Sly(ask)")
    "c" '(:ignore t :which-key "Compile")
    "cc" '(sly-compile-file :which-key "Compile File")
    "cC" '(sly-compile-and-load-file :which-key "Compile and Load File")
    "cl" '(sly-load-file :which-key "Load File")
    "e" '(sly-eval-buffer :which-key "Evaluate Buffer")
    "r" '(:ignore t :which-key "Repl")
    "rc" '(sly-mrepl-clear-repl :which-key "Clear")
    "rq" '(sly-quit-lisp :which-key "Quit")
    "rr" '(sly-restart-inferior-lisp :which-key "Restart")
    "rs" '(sly-mrepl-sync :which-key "Sync"))
  (nh/local-leader-keys
    :keymaps 'rust-mode-map
    "c" '(rust-run-clippy :which-key "Run Clippy")))

;; Evil Mode!!!
;; Define what modes need to begin in emacs mode
(defun nh/evil-hook ()
  (dolist (mode '(eshell-mode
		    term-mode
		    shell-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

(use-package evil
	       :init
	       (setq evil-want-integration t)
	       (setq evil-want-keybinding nil)
	       (setq evil-want-C-u-scroll t)
	       (setq evil-want-C-d-scroll t)
	       (setq evil-want-C-i-jump nil)
	       :config
	       (add-hook 'evil-mode-hook 'nh/evil-hook)
	       (evil-mode 1)
	       (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
	       (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

	       ;; Use visual line motions even outside of visual-line-mode buffers
	       (evil-global-set-key 'motion "j" 'evil-next-visual-line)
	       (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

	       (evil-set-initial-state 'messages-buffer-mode 'normal)
	       (evil-set-initial-state 'dashboard-mode 'normal))

;; Evil Collection
;; Collection of evil mode configs for different modes
(use-package evil-collection
	       :after evil
	       :config
	       (evil-collection-init))

;;; Embark
(use-package embark
  :bind
  (("C-h B" . embark-bindings)
   ("s-." . embark-act)
   ("s-," . embark-dwim)
   ("s-e" . embark-export)
   ("s-b" . embark-become))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult)

;;; Ace Window

(use-package ace-window
  :bind (("M-o" . ace-window))
  :custom
  (aw-scope 'frame)
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-minibuffer-flag t)
  :config
  (ace-window-display-mode 1)
  (setq aw-dispatch-always t))

;;(eval-when-compile
;;  (defmacro nh/embark-ace-action (fn)
;;    `(defun ,(intern (concat "nh/embark-ace-" (symbol-name fn))) ()
;;       (interactive)
;;       (with-demoted-errors "%s"
;;         (require 'ace-window)
;;         (let ((aw-dispatch-always t))
;;           (aw-switch-to-window (aw-select nil))
;;           (call-interactively (symbol-function ',fn)))))))

;;(define-key embark-file-map     (kbd "o") (nh/embark-ace-action find-file))
;;(define-key embark-buffer-map   (kbd "o") (nh/embark-ace-action switch-to-buffer))
;;(define-key embark-bookmark-map (kbd "o") (nh/embark-ace-action bookmark-jump))

;;(eval-when-compile
;;  (defmacro nh/embark-split-action (fn split-type)
;;   `(defun ,(intern (concat "nh/embark-"
;;                             (symbol-name fn)
;;                             "-"
;;                             (car (last  (split-string
;;                                          (symbol-name split-type) "-"))))) ()
;;       (interactive)
;;       (funcall #',split-type)
;;       (call-interactively #',fn))))

;;(define-key embark-file-map     (kbd "2") (nh/embark-split-action find-file split-window-below))
;;(define-key embark-buffer-map   (kbd "2") (nh/embark-split-action switch-to-buffer split-window-below))
;;(define-key embark-bookmark-map (kbd "2") (nh/embark-split-action bookmark-jump split-window-below))

;;(define-key embark-file-map     (kbd "3") (nh/embark-split-action find-file split-window-right))
;;(define-key embark-buffer-map   (kbd "3") (nh/embark-split-action switch-to-buffer split-window-right))
;;(define-key embark-bookmark-map (kbd "3") (nh/embark-split-action bookmark-jump split-window-right))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package lisp-mode
  :ensure nil
  :mode
  ("\\.lisp\\'" . lisp-mode)
  ("\\.ros\\'" . lisp-mode)
  :config
  (defun sly-ask ()
    (interactive)
    (let ((current-prefix-arg '(4)))
      (call-interactively #'sly))))

(use-package lispy
  :hook
  (emacs-lisp-mode . lispy-mode)
  (lisp-mode . lispy-mode))

(use-package lispyville
  :hook (lispy-mode . lispyville-mode)
  :config
  (lispyville-set-key-theme '(operators c-w additional
                              additional-movement slurp/barf-cp
                              prettify)))

(use-package sly
  :commands (sly sly-connect)
  :init
  (setq sly-symbol-completion-mode nil
        sly-default-lisp 'roswell
        sly-lisp-implementations
        `((sbcl ("sbcl") :coding-system uft-8-unix)
          (ccl ("ccl") :coding-system uft-8-unix)
          (roswell ("ros" "-Q" "run")))))

(use-package haskell-mode)

(use-package rust-mode)

(use-package dyalog-mode)

(use-package auctex)
;;:load-path "/home/nick/.emacs.d/elpaca/repos/auctex-13.2/auctex.el")
;; (load "/home/nick/.emacs.d/elpaca/repos/auctex-13.2/auctex.el" nil t t)
;; (load "/home/nick/.emacs.d/elpaca/repos/auctex-13.2/preview-latex.el" nil t t)
;; (elpaca-test
  ;; :early-init (setq package-enable-at-startup nil
                    ;; elpaca-ui-row-limit most-positive-fixnum
                    ;; elpaca-menu-functions '(elpaca-menu-gnu-devel-elpa))
  ;; :init (elpaca (auctex :pre-build (("./autogen.sh")
                                    ;; ("./configure" "--without-texmf-dir" "--with-lispdir=.")
                                    ;; ("make"))))
  ;; (elpaca-wait)
  ;; (elpaca-test-log
   ;; "auctex || !^<\\\\|\\}\\\\|\\]\\\\|\\)\\\\|\\>\\\\|%\\\\|^\\\\.\\\\|\\\\*\\\\|\\\\\\["))

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :ensure nil
  :config
  (add-hook 'org-mode-hook 'nh/after-org-mode-load)
  (add-hook 'org-mode-hook #'org-modern-mode)
  (setq org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-fontify-quote-and-verse-blocks t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 2
        org-hide-blocks-startup nil
        org-src-preserve-identation nil
        org-startup-folded 'contents
        org-cycle-separator-lines 2))

(defun nh/after-org-mode-load ()
  "Set these after org mode load"
  (visual-line-mode 1)
  (require 'org-indent)
  (org-indent-mode)
  (diminish org-indent-mode))

(use-package org-modern)

(use-package org-agenda
  :ensure nil
  :config
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))

(use-package evil-org
  :hook (org-mode . evil-org-mode))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (lisp . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (haskell . t)
   (latex . t)
   (python . t)
   (sql . t)
   (sqlite . t)))

(use-package org-tempo
  :ensure nil
  :config (setq org-structure-template-alist '(("sh" . "src shell")
					       ("el" . "src emacs-lisp")
					       ("lgr" . "src ledger")
					       ("lisp" . "src lisp")
					       ("tmux" . "src tmux")
					       ("hs" . "src haskell"))))

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(use-package which-key
  :init (which-key-mode 1)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package vertico
  :custom
  (vertico-cycle t)
  :custom-face
  (vertico-current ((t (:background "#3a3f5a"))))
  :init
  (vertico-mode 1))

(use-package savehist
  :ensure nil
  :init 
  (savehist-mode 1))

(use-package consult
  :demand t
  :bind (("C-s" . consult-line)
         ("C-M-l" . consult-imenu)
         :map minibuffer-local-map
         ("C-r" . consult-history))
  :custom
  (completion-in-region-function #'consult-completion-in-region))

(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file styles . (partial-completion)))))

(use-package marginalia
  :after vertico
  :custom
  (marinalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode 1))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(vertico-posframe epkg-marginalia which-key vertico toc-org smart-mode-line sly rust-mode ripgrep rainbow-mode rainbow-delimiters org-modern orderless marginalia lispyville haskell-mode general evil-org evil-collection embark-consult dyalog-mode diminish dashboard auctex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

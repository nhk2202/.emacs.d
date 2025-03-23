;; -*- lexical-binding: t -*-

(package-initialize)
(with-eval-after-load 'package
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t))

(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq use-package-expand-minimally t)

(use-package diminish)

(use-package gcmh
  :diminish gcmh-mode
  :custom
  (gcmh-idle-delay 10)
  :config
  (gcmh-mode 1))

(load custom-file)

(setq isearch-repeat-on-direction-change t
      isearch-wrap-pause 'no)

(setq tab-bar-show 1)
(column-number-mode 1)
(setq-default fill-column 80)
(setq truncate-lines t)
(setq scroll-margin 10)

(repeat-mode 1)

(setq which-key-idle-delay 0.5)
(which-key-mode 1)
(diminish 'which-key-mode)

(setq read-answer-short t)
(setq enable-recursive-minibuffer t
      read-extended-command-predicate #'command-completion-default-include-p
      minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt)
      history-delete-duplicates t)
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
(savehist-mode 1)
(recentf-mode 1)
(minibuffer-electric-default-mode 1)
(minibuffer-depth-indicate-mode 1)

(setq help-window-keep-selected t)

(setq make-backup-files nil)
(global-auto-revert-mode 1)

(setq mark-even-if-inactive nil
      delete-selection-mode t)

(require-theme 'modus-themes)
(setq modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-prompts '(heavy)
      modus-themes-common-palette-overrides '((comment yellow-cooler)
					      (string green-cooler)
					      (bg-mode-line-active bg-sage)
					      (fg-mode-line-active fg-main)
					      (border-mode-line-active bg-green-intense)
					      (fg-prompt cyan)
					      (bg-prompt bg-cyan-nuanced))
      modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))
(define-key global-map (kbd "<f5>") #'modus-themes-toggle)
(modus-themes-load-theme 'modus-vivendi-tinted)

(use-package magit
  :bind ("C-c g" . magit))

(use-package vertico
  :custom
  (vertico-resize t)
  :config
  (setq completion-styles '(basic partial-completion flex)
	completion-ignore-case t)
  (keymap-set vertico-map "C-S-n" #'vertico-next-group)
  (keymap-set vertico-map "C-S-p" #'vertico-previous-group)
  (vertico-mode 1))

(use-package vertico-directory
  :after vertico
  :ensure nil
  :bind (:map vertico-map
	      ("RET" . vertico-directory-enter)
	      ("DEL" . vertico-directory-delete-char))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package vertico-multiform
  :after vertico
  :ensure nil
  :custom
  (vertico-multiform-categories '((embark-keybinding grid)))
  :config
  (vertico-multiform-mode 1))

(use-package marginalia
  :bind (:map minibuffer-local-map
	      ("M-a" . marginalia-cycle))
  :init
  (marginalia-mode 1))

(use-package consult
  :bind (("C-c k" . consult-kmacro)
	 ("C-h C-i" . consult-info)
	 ([remap Info-search] . consult-info)
	 ("C-y" . consult-yank-from-kill-ring)
	 ("C-x b" . consult-buffer)
	 ("C-x 4 b" . consult-buffer-other-window)
	 ("C-x t b" . consult-buffer-other-tab)
	 ("C-c c e" . consult-compile-error)
	 ("C-c c f" . consult-flymake)
	 ("C-c s f" . consult-fd)
	 ("C-c s g" . consult-ripgrep)
	 ("C-c s G" . consult-git-grep)
	 ("C-x <ESC> <ESC>" . consult-complex-command)
	 :map minibuffer-local-map
	 ([remap next-matching-history-element] . consult-history)
	 ([remap previous-matching-history-element] . consult-history))
  :custom
  (consult-narrow-key "M--")
  (consult-widen-key "M-=")
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  (setq xref-show-xrefs-function #'consult-xref
	xref-show-definition-function #'consult-xref)
  :config
  (consult-customize
   consult--source-bookmark
   consult--source-file-register
   consult--source-recent-file
   consult--source-project-recent-file
   :preview-key "M-o"))

(use-package embark
  :bind (("C-." . embark-act)
	 ("M-." . embark-dwim)
	 ("C-h b" . embark-bindings))
  :custom
  (embark-help-key "?")
  (embark-quit-after-action nil)
  :init
  (setq y-or-n-p-use-read-key t)
  (setq prefix-help-command #'embark-prefix-help-command)
  (add-to-list 'display-buffer-alist '("\\`\\*Embark Collect \\(Live\\|Completion\\)\\*"
				       nil
				       (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package wgrep
  :commands (wgrep-change-to-wgrep-mode)
  :custom
  (wgrep-enable-key "i"))

(use-package helpful
  :bind (("C-h x" . helpful-callable)
	 ("C-h v" . helpful-variable)
	 ("C-h f" . helpful-command)
	 ("C-h F" . helpful-function)
	 ("C-h k" . helpful-key)
	 ("C-h M" . helpful-macro)
	 ("C-h ." . helpful-at-point)))

(use-package auctex
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t))

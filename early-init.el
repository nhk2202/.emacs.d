;; -*- lexical-binding: t -*-

(setq load-prefer-newer t)

(setq package-enable-at-startup nil)

(setq gc-cons-threshold most-positive-fixnum)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(setq frame-resize-pixelwise t)
(setq frame-inhibit-implied-resize nil)
(setq default-frame-alist '((menu-bar-lines . 0)
			    (tool-bar-lines . 0)
			    (horizontal-scroll-bars)
			    (vertical-scroll-bars)
			    (fullscreen . maximized)))
(setq inhibit-startup-screen t)

(set-language-environment "UTF-8")
(setq default-input-method nil)

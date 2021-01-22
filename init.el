;;; init.el --- asdf

;;; Commentary:
;; xxx

;;; Code:
(require 'package)

(setq package-archives
      '(("gnu"         . "http://elpa.gnu.org/packages/")
        ("org"         . "http://orgmode.org/elpa/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package company
  :diminish 'company-mode
  :config (add-hook 'after-init-hook 'global-company-mode))
(use-package cyberpunk-theme :config (load-theme 'cyberpunk))

(use-package nyan-mode :if window-system :config (nyan-mode))

(use-package toc-org :config (defun *-org-insert-toc ()
			       "Create table of contents (TOC) if current buffer is in `org-mode'."
			       (when (= major-mode 'org-mode)
				 toc-org-insert-toc)))


(use-package nnreddit :config ; (custom-set-variables '(gnus-select-method (quote (nnreddit "")))))
  (add-to-list 'gnus-secondary-select-methods
               '(nnreddit "")))

(use-package yasnippet :config (yas-global-mode))


(use-package helm :straight t
  :config ((lambda()

	     (define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
	     (define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
	     (define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)
	     (global-set-key (kbd "M-x") 'helm-M-x)
	     ; (global-set-key (kbd "C-x C-f") 'helm-find-files)
	     (global-set-key (kbd "M-y") 'helm-show-kill-ring)
	     (global-set-key (kbd "C-x C-b") 'helm-mini)
	     ;;(global-set-key (kbd "C-x C-f") 'helm-find-files)
	     (global-set-key (kbd "C-c h s") 'helm-semantic-or-imenu)
	     (global-set-key (kbd "C-c h m") 'helm-man-woman)
	     (setq helm-buffers-fuzzy-matching t)
	     (global-set-key (kbd "C-c h f") 'helm-find)
	     (global-set-key (kbd "C-c h l") 'helm-locate)
	     (global-set-key (kbd "C-c h o") 'helm-occur)
	     (global-set-key (kbd "C-c h r") 'helm-resume)
	     (define-key 'help-command (kbd "C-f") 'helm-apropos)
	     (define-key 'help-command (kbd "r") 'helm-info-emacs)
	     ;; use helm to list eshell history
	     (add-hook 'eshell-mode-hook
		       #'(lambda ()
			   (define-key eshell-mode-map (kbd "M-l")  'helm-eshell-history)))
	     (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)
	     (helm-mode 1)
	     )))

(use-package undo-tree :config (global-undo-tree-mode))
(use-package ace-window)
(use-package flycheck :ensure t :config (global-flycheck-mode))
(use-package flycheck-pos-tip :ensure t :config (flycheck-pos-tip-mode))
(use-package rainbow-delimiters :config (rainbow-delimiters-mode))
(use-package org-bullets :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(global-set-key (kbd "C-z") 'undo-tree-undo)
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-c C-a") 'org-agenda)
(global-linum-mode t)
(hl-line-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-set-key "\C-j" 'goto-line)
(global-set-key (kbd "RET") 'newline-and-indent)
(flyspell-mode)
(flyspell-prog-mode)
(ispell-change-dictionary "english")

(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))

(setq ring-bell-function (lambda ()(message "Bing!")))
(setq scroll-step 1
      scroll-margin 1
      scroll-conservatively 10000)

(defun org-latex-setting()
  ;;(require 'org-latex)
  ;;(require 'ox-latex)
  ;;(add-to-list 'org-latex-packages-alist '("" "minted"))
  ;; (setq org-latex-listings 'minted)
  ;; (setq org-latex-minted-options
  ;; 	'(("frame" "lines")
  ;;         ;;("bgcolor" "bg")
  ;; 	  ("fontsize" "\\scriptsize")
  ;; 	  ("linenos" "true")))
  ;;   (setq org-export-latex-hyperref-format "\\ref{%s}")
  ;; (setq org-latex-preview-ltxpng-directory "~/")
  (setq org-latex-pdf-process
        (list "xelatex  -shell-escape -output-directory %o %f"
              ;;"bibtex %b"
              ;;"xelatex -interaction nonstopmode -output-directory %o %f"
              "xelatex  -shell-escape -output-directory %o %f")))

(defun wc (beg end)
  "用于统计字符数，包括中文（含中文标点）、英文字母、空格、段落和其他字符（数字等等）。
与word当中记数的方式略有不同，不会把连续的数字、英文标点只统计成一个，也就是此函数记录的是实际的字符数目。
这与word当中统计的字符数是一样的。"
  (interactive "r")
  (message "begin:%d\tend:%d" beg end)
  (save-excursion
    (let ((cn 0)
          (en 0)
          (spc 0)
          (par 1)
          (others 0)
          char)
      (goto-char beg)
      (while (< (point) end)
        (setq char (char-after))
        (cond ((eq ?\s char) (setq spc (1+ spc)))
              ((eq ?\n char) (setq par (1+ par)))
              ((< 127 char) (setq cn (1+ cn)))
              ((or
                (and (<= ?a char) (<= char ?z))
                (and (<= ?A char) (<= char ?Z))
                ) (setq en (1+ en)))
              (t (setq others (1+ others))))
        (forward-char 1))
      (message "共有%d个字，%d个字母，%d个空格，%d个其他字符，%d个段落" cn en spc others par))))


(org-latex-setting)

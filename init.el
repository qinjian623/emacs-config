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
  :config (progn
	    (global-set-key (kbd "M-/") 'company-complete)
	    (setq company-idle-delay 0.1)
	    (setq company-tooltip-flip-when-above t)
	    (setq company-minimum-prefix-length 2)
	    (add-hook 'after-init-hook 'global-company-mode)))

(use-package cyberpunk-theme :config (load-theme 'cyberpunk))

(use-package nyan-mode :if window-system :config (nyan-mode))

(use-package toc-org :config (defun *-org-insert-toc ()
			       "Create table of contents (TOC) if current buffer is in `org-mode'."
			       (when (= major-mode 'org-mode)
				 toc-org-insert-toc)))

(use-package nnreddit :config ; (custom-set-variables '(gnus-select-method (quote (nnreddit "")))))
  (add-to-list 'gnus-secondary-select-methods
               '(nnreddit "")))

(use-package yasnippet :config (progn
				 (yas-global-mode)
				 (global-set-key (kbd "C-c C-c") 'yas-insert-snippet)))

(use-package helm
  :config (progn
	    (setq helm-split-window-in-side-p           t
		  helm-buffers-fuzzy-matching           t
		  helm-move-to-line-cycle-in-source     t
		  helm-ff-search-library-in-sexp        t
		  helm-ff-file-name-history-use-recentf  t)
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
	    (helm-mode 1)))

(use-package undo-tree :config (global-undo-tree-mode))
(use-package ace-window)
(use-package flycheck :ensure t :config
  (progn
    (global-flycheck-mode)))

(use-package dired-git :config   (add-hook 'dired-mode-hook 'dired-git-mode))
(use-package dired-icon :config   (add-hook 'dired-mode-hook 'dired-icon-mode))

(use-package flycheck-pos-tip :ensure t :config
  (with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode)))
(use-package rainbow-delimiters :config (rainbow-delimiters-mode))
(use-package org-bullets :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(use-package beacon :config (beacon-mode 1))
(use-package anzu :config (global-anzu-mode))
(use-package ranger :config (ranger-override-dired-mode t))
(use-package org-download)

(global-set-key (kbd "C-z") 'undo-tree-undo)
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-c C-a") 'org-agenda)


(defun custom/kill-this-buffer ()
  "Kill `current-buffer' shortcut."
  (interactive) (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") 'custom/kill-this-buffer)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(blink-cursor-mode -1)
(menu-bar-mode -1)
(show-paren-mode t)
(global-auto-revert-mode t)
(recentf-mode 1)
(savehist-mode 1)
(global-hl-line-mode 1)
(global-linum-mode t)
(setq avy-background t)
(setq avy-style 'at-full)
(setq avy-style 'at-full)

(setq visible-bell t)
(setq ring-bell-function 'ignore)

(global-set-key "\C-j" 'goto-line)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-j") 'avy-goto-word-or-subword-1)
(global-set-key (kbd "C-a") 'back-to-indentation)


(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

;; (when (member "Courier" (font-family-list))
;;   (set-face-attribute 'default nil :font "Courier"))

;; specify font for all unicode characters
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

;; specify font for chinese characters using default chinese font on linux
(when (member "WenQuanYi Micro Hei" (font-family-list))
  (set-fontset-font t '(#x4e00 . #x9fff) "WenQuanYi Micro Hei" ))

(flyspell-mode)
(flyspell-prog-mode)
(ispell-change-dictionary "english")
(fset 'yes-or-no-p 'y-or-n-p)

(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))
(setq inhibit-startup-screen t)

(setq scroll-step 1
      scroll-margin 1
      scroll-conservatively 10000)
(setq-default indent-tabs-mode nil)

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
  (setq org-agenda-custom-commands
        '(("c" "Simple agenda view"
           ((tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "High-priority unfinished tasks:")))
            (agenda "")
            (alltodo "")))))
  (setq org-latex-pdf-process
        (list "xelatex  -shell-escape -output-directory %o %f"
              ;;"bibtex %b"
              ;;"xelatex -interaction nonstopmode -output-directory %o %f"
              "xelatex  -shell-escape -output-directory %o %f")))

(org-latex-setting)

(defvar wc-regexp-chinese-char-and-punc
  (rx (category chinese)))
(defvar wc-regexp-chinese-punc
  "[。，！？；：「」『』（）、【】《》〈〉※—]")
(defvar wc-regexp-english-word
  "[a-zA-Z0-9-]+")

(defun wc ()
  "「較精確地」統計中/日/英文字數。
- 文章中的註解不算在字數內。
- 平假名與片假名亦包含在「中日文字數」內，每個平/片假名都算單獨一個字（但片假
  名不含連音「ー」）。
- 英文只計算「單字數」，不含標點。
- 韓文不包含在內。

※計算標準太多種了，例如英文標點是否算入、以及可能有不太常用的標點符號沒算入等
。且中日文標點的計算標準要看 Emacs 如何定義特殊標點符號如ヴァランタン・アルカン
中間的點也被 Emacs 算為一個字而不是標點符號。"
  (interactive)
  (let* ((v-buffer-string
          (progn
            (if (eq major-mode 'org-mode) ; 去掉 org 文件的 OPTIONS（以#+開頭）
                (setq v-buffer-string (replace-regexp-in-string "^#\\+.+" ""
                                                                (buffer-substring-no-properties (point-min) (point-max))))
              (setq v-buffer-string (buffer-substring-no-properties (point-min) (point-max))))
            (replace-regexp-in-string (format "^ *%s *.+" comment-start) "" v-buffer-string)))
                                        ; 把註解行刪掉（不把註解算進字數）。
         (chinese-char-and-punc 0)
         (chinese-punc 0)
         (english-word 0)
         (chinese-char 0))
    (with-temp-buffer
      (insert v-buffer-string)
      (goto-char (point-min))
      ;; 中文（含標點、片假名）
      (while (re-search-forward wc-regexp-chinese-char-and-punc nil :no-error)
        (setq chinese-char-and-punc (1+ chinese-char-and-punc)))
      ;; 中文標點符號
      (goto-char (point-min))
      (while (re-search-forward wc-regexp-chinese-punc nil :no-error)
        (setq chinese-punc (1+ chinese-punc)))
      ;; 英文字數（不含標點）
      (goto-char (point-min))
      (while (re-search-forward wc-regexp-english-word nil :no-error)
        (setq english-word (1+ english-word))))
    (setq chinese-char (- chinese-char-and-punc chinese-punc))
    (message
     (format "中日文字數（不含標點）：%s
中日文字數（包含標點）：%s
英文字數（不含標點）：%s
=======================
中英文合計（不含標點）：%s"
             chinese-char chinese-char-and-punc english-word
             (+ chinese-char english-word)))))

(defun wc_word (beg end)
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




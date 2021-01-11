(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(load-theme 'material)
(load-theme 'cyberpunk)
(tabbar-mode)

(defun my-view-and-layout-settings()
  (progn
    ;; (telephone-line-mode)
    (load-theme 'cyberpunk)
    ;; (load-theme 'material)	       
    ;; the toolbar is just a waste of valuable screen estate
    ;; in a tty tool-bar-mode does not properly auto-load, and is
    ;; already disabled anyway
    (when (fboundp 'tool-bar-mode)
      (tool-bar-mode -1))
    (menu-bar-mode -1)
    ;; the blinking cursor is nothing, but an annoyance
    (when (fboundp 'scroll-bar-mode)
      (scroll-bar-mode -1))
    (blink-cursor-mode -1)
                                        ; (scroll-bar-mode -1)
    ;; disable startup screen
    (setq inhibit-startup-screen t)
    ;; nice scrolling
    (setq scroll-margin 0
          scroll-conservatively 100000
          scroll-preserve-screen-position 1)
    ;; mode line settings
    (line-number-mode t)
    (column-number-mode t)
    (size-indication-mode t)
    ;; enable y/n answers
    (fset 'yes-or-no-p 'y-or-n-p)
    (setq frame-title-format
          '( "Baymax -> " (:eval (if (buffer-file-name)
                                     (abbreviate-file-name (buffer-file-name))
                                   "%b"))))
    ;;(beacon-mode)
    ;;(require 'beacon)
    (beacon-mode t)
    ))



(defun my-editor-settings()
  ;; Editor Settings
  (setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
  (setq-default tab-width 8)            ;; but maintain correct appearance
  ;; No sound
  (show-paren-mode t)
  (setq visible-bell t)
  (setq ring-bell-function 'ignore)

  ;; autosave the undo-tree history
  (setq undo-tree-history-directory-alist
        `((".*" . ,temporary-file-directory)))
  (setq undo-tree-auto-save-history t)
  ;; revert buffers automatoically when underlying files are changed externally
  (global-auto-revert-mode t)
  (recentf-mode 1)
  (savehist-mode 1)
  (global-hl-line-mode 1)
  ;; flyspell-mode does spell-checking on the fly as you type
  (require 'flyspell)
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra"))

  ;; avy allows us to effectively navigate to visible things
  (setq avy-background t)
  (setq avy-style 'at-full)
  (setq avy-style 'at-full)
  ;; anzu-mode enhances isearch & query-replace by showing total matches and current match position
  (require 'anzu)
  ;; (diminish 'anzu-mode)
  (global-anzu-mode)

  ;; (require 'compile)
  ;; (setq compilation-ask-about-save nil  ; Just save before compiling
  ;;       compilation-always-kill t       ; Just kill old compile processes before starting the new one
  ;;       compilation-scroll-output 'first-error ; Automatically scroll to first error
  ;;       )
  )

(defun my-company-setttings()
  (progn
    (global-company-mode)
    (eval-after-load 'company
      '(add-to-list 'company-backends 'company-c-headers))
    (eval-after-load 'company
      '(add-to-list 'company-backends 'company-semantic))
    (eval-after-load 'company
      '(add-to-list 'company-backends 'company-irony))
    (setq company-idle-delay 0.1)
    (setq company-tooltip-limit 15)
    (setq company-minimum-prefix-length 2)
    ;; invert the navigation direction if the the completion popup-isearch-match
    ;; is displayed on top (happens near the bottom of windows)
    (setq company-tooltip-flip-when-above t)
                                        ; (yas-global-mode 1)
    (global-flycheck-mode 1)
    ;;(eval-after-load 'flycheck
    ;;  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
    (eval-after-load 'flycheck-tip
      '(flycheck-tip-use-timer 'verbose))
    (eval-after-load 'flycheck-tip
      '(setq error-tip-timer-delay 0.1))))


(defun my-key-bindings()
  ;; Unset useless key bindings
  (global-unset-key (kbd "C-z"))
  (global-set-key (kbd "C-z") 'undo)
  (global-unset-key (kbd "C-j"))
  (global-unset-key (kbd "C-x b"))

  (defun custom/kill-this-buffer ()
    (interactive) (kill-buffer (current-buffer)))
  (global-set-key (kbd "C-x k") 'custom/kill-this-buffer)

  ;; Font size
  (global-set-key (kbd "C-+") 'text-scale-increase)
  (global-set-key (kbd "C--") 'text-scale-decrease)
  (global-set-key (kbd "C-x o") 'ace-window)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-j") 'avy-goto-word-or-subword-1)
  (global-set-key (kbd "C-a") 'back-to-indentation))


(defun my-helm-settings()
  (progn
    (require 'helm-config)
    
    
    
    ;;(require 'helm-projectile)
    ;; (helm-fuzzy-mode -1)
    ;; See https://github.com/bbatsov/prelude/pull/670 for a detailed
    ;; discussion of these options.
    (setq
     helm-split-window-in-side-p           t
     helm-buffers-fuzzy-matching           t
     helm-move-to-line-cycle-in-source     t
     helm-ff-search-library-in-sexp        t
     helm-ff-file-name-history-use-recentf  t)
    
    (global-set-key (kbd "M-x") 'helm-M-x)
    (global-set-key (kbd "M-/") 'company-complete)
    (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
    (global-set-key (kbd "M-y") 'helm-show-kill-ring)
    (global-set-key (kbd "C-h f") 'helm-apropos)
    ;; (setq projectile-completion-system 'helm)
    ;;(helm-projectile-on)
    ))



(defun org-latex-setting()
  ;;(require 'org-latex)
  ;;(require 'ox-latex)
  ;;(add-to-list 'org-latex-packages-alist '("" "minted"))
  ;;(setq org-latex-listings 'minted)
  ;; (setq org-latex-minted-options
  ;;       '(("frame" "lines")
  ;;         ;;("bgcolor" "bg")
  ;;         ("fontsize" "\\scriptsize")
  ;;         ("linenos" "true")))

  ;;For org-mode version < 8
  ;;(setq org-export-latex-listings 'minted)
  ;;(add-to-list 'org-export-latex-packages-alist '("" "minted"))
  ;;(setq org-export-latex-minted-options
  ;;	'(("frame" "lines")
  ;;("fontsize" "\\scriptsize")
  ;;	  ("linenos" "true")))
  ;; Agenda Settings
  (setq org-agenda-files '("~/Dropbox/TODO/"))
  ;; (setq org-agenda-custom-commands
  ;;       '(("c" "Simple agenda view"
  ;;          ((agenda "")
  ;;           (alltodo "")))))
  (setq org-agenda-custom-commands
        '(("c" "Simple agenda view"
           ((tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "High-priority unfinished tasks:")))
            (agenda "")
            (alltodo "")))))

  (setq org-export-latex-hyperref-format "\\ref{%s}")
  (setq org-latex-preview-ltxpng-directory "~/")
  (getenv "PATH")
  (setenv "PATH"
          (concat
           "/Library/TeX/texbin/xelatex" ":" (getenv "PATH")))
  
  (setq org-latex-pdf-process
        (list "xelatex  -shell-escape -output-directory %o %f"
              ;;"bibtex %b"
              ;;"xelatex -interaction nonstopmode -output-directory %o %f"
              "xelatex  -shell-escape -output-directory %o %f")))

(org-latex-setting)
(my-helm-settings)

(my-company-setttings)
(my-key-bindings)
(my-view-and-layout-settings)
(my-editor-settings)
(global-linum-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("7922b14d8971cce37ddb5e487dbc18da5444c47f766178e5a4e72f90437c0711" "6bc387a588201caf31151205e4e468f382ecc0b888bac98b2b525006f7cb3307" "c5ad91387427abc66af38b8d6ea74cade4e3734129cbcb0c34cc90985d06dcb3" "27b97024320d223cbe0eb73104f2be8fcc55bd2c299723fc61d20057f313b51c" default)))
 '(package-selected-packages
   (quote
    (org-bullets org-make-toc flycheck helm-fuzzy helm-projectile projectile helm-org helm-org-recent-headings helm-osx-app company ace-window anzu telephone-line rainbow-delimiters beacon helm material-theme tabbar markdown-mode anaconda-mode cyberpunk-theme cyberpunk-2019-theme ahungry-theme)))
 '(tabbar-mode t nil (tabbar)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )




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



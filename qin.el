;;;
;;;
;;;
(defun common-mode-hooks()
  (auto-fill-mode -1)
  (toggle-truncate-lines -1)
  (hl-line-mode -1))

(defun add-common-mode-hooks (l)
  (dolist (item l)
    (add-hook item 'common-mode-hooks)))

(add-common-mode-hooks '(
                         emacs-lisp-mode-hook
                         emacs-startup-hook
                         org-mode-hook))



(setq package-archives
      '(("gnu"         . "http://elpa.gnu.org/packages/")
        ("org"         . "http://orgmode.org/elpa/")
        ("melpa"       . "http://melpa.milkbox.net/packages/")
        ("marmalade"   . "http://marmalade-repo.org/packages/")))
(package-initialize)


;;; Global mode
(golden-ratio-mode)
(yas-global-mode)
(undo-tree-mode)

;; TODO Do we need this?
(setq sentence-end-double-space nil)
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
;;; Coding settings
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;; Auto Complete
(global-auto-complete-mode)

;;; Clojure
(defun ac-nrepl-settings ()
  (progn
    (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
    (add-hook 'nrepl-mode-hook
              'nrepl-turn-on-eldoc-mode)

    (add-hook 'nrepl-interaction-mode 'ac-nrepl-setup)
    (add-hook 'nrepl-interaction-mode-hook
              'nrepl-turn-on-eldoc-mode)
    (eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))))
(ac-nrepl-settings)

;;; Emacs Lisp
(add-hook 'emacs-lisp-mode-hook
          '(lambda () (progn
                    (rainbow-delimiters-mode t)
                    (hl-line-mode -1))))

;;; UI settings.
(load-theme 'deeper-blue)
(nyan-mode)
(global-linum-mode t)
(setq frame-title-format "%n%F/%b")
(setq ring-bell-function (lambda ()(message "Bing!")))
(setq scroll-step 1
      scroll-margin 1
      scroll-conservatively 10000)

(defun toggle-fullscreen ()
      "Toggle full screen"
      (interactive)
      (set-frame-parameter
       nil 'fullscreen
       (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;;; Key binding settings
;;; Need to check what the sk have done for us.
(global-set-key (kbd "<f11>") 'toggle-fullscreen)
(global-set-key (kbd "<f9>") 'smart-compile)
(global-set-key [C-tab] 'other-window)
(global-set-key "\C-j" 'goto-line)
(global-set-key "\C-z" 'undo-tree-undo)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key "\C-x o" 'ace-window)
;;; Spell check
;;; TODO auto-correct short key
(defun global-misc-settings ()
  (progn
    (setq-default ispell-program-name "Aspell")
    (ac-flyspell-workaround)
    (ispell-change-dictionary "american" t)))
(global-misc-settings)

;;;Helm Settings
(require 'helm)
(require 'helm-config)
(require 'helm-eshell)
(require 'helm-files)
(require 'helm-grep)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions
                                        ; using C-z

(define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

(setq
 helm-google-suggest-use-curl-p t
 helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
 helm-quick-update t ; do not display invisible candidates
 helm-idle-delay 0.01 ; be idle for this many seconds, before updating in delayed sources.
 helm-input-idle-delay 0.01 ; be idle for this many seconds, before updating candidate buffer
 helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.

 helm-split-window-default-side 'other ;; open helm buffer in another window
 helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window
 helm-buffers-favorite-modes (append helm-buffers-favorite-modes
                                     '(picture-mode artist-mode))
 helm-candidate-number-limit 200 ; limit the number of displayed canidates
 helm-M-x-requires-pattern 0     ; show all candidates when set to 0
 helm-boring-file-regexp-list
 '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "\\.i$") ; do not show these files in helm buffer
 helm-ff-file-name-history-use-recentf t
 helm-move-to-line-cycle-in-source t ; move to end or beginning of source
                                        ; when reaching top or bottom of source.
 ido-use-virtual-buffers t      ; Needed in helm-buffers-list
 helm-buffers-fuzzy-matching t          ; fuzzy matching buffer names when non--nil
                                        ; useful in helm-mini that lists buffers
 )

(define-key helm-map (kbd "C-x 2") 'helm-select-2nd-action)
(define-key helm-map (kbd "C-x 3") 'helm-select-3rd-action)
(define-key helm-map (kbd "C-x 4") 'helm-select-4rd-action)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h s") 'helm-semantic-or-imenu)
(global-set-key (kbd "C-c h m") 'helm-man-woman)
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

;;; Fonts settings
(defun fonts-settings ()
  ;; 字体设置，来自emacser.com
  (defun qiang-set-font (english-fonts
                         english-font-size
                         chinese-fonts
                         &optional chinese-font-size)
    "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
    (require 'cl)                         ; for find if
    (let ((en-font (qiang-make-font-string
                    (find-if #'qiang-font-existsp english-fonts)
                    english-font-size))
          (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
                              :size chinese-font-size)))
      ;; Set the default English font
      ;; 
      ;; The following 2 method cannot make the font settig work in new frames.
      ;; (set-default-font "Consolas:pixelsize=18")
      ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
      ;; We have to use set-face-attribute
      (message "Set English Font to %s" en-font)
      (set-face-attribute
       'default nil :font en-font)
      ;; Set Chinese font 
      ;; Do not use 'unicode charset, it will cause the english font setting invalid
      (message "Set Chinese Font to %s" zh-font)
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font)
                          charset
                          zh-font))))
  (defun qiang-font-existsp (font)
    (if (null (x-list-fonts font))
        nil t))
  (defun qiang-make-font-string (font-name font-size)
    (if (and (stringp font-size) 
             (equal ":" (string (elt font-size 0))))
        (format "%s%s" font-name font-size)
      (format "%s %s" font-name font-size)))
  (qiang-set-font
   qj-english-fonts qj-font-size qj-chinese-fonts))

(defvar
  qj-english-fonts
  '("Courier New" "Courier 10 Pitch" "Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" ))
(defvar
  qj-chinese-fonts
  '("Wawati SC" "文泉驿等宽微米黑" "SimSun" "Hei" "Microsoft Yahei"   "黑体" "新宋体" "宋体"))
(defvar qj-font-size  ":pixelsize=18")
(fonts-settings)






;;; TODO Regin, all things to be done.

;;; X-window settings
(defun x-window-settings ()
  (defun window-system-settings ()
    (progn
      (scroll-bar-mode -1)
      (fonts-settings)))
  (if window-system
      (progn
        (window-system-settings)
        (nox-window-settings))))

(defun nox-window-settings ()
  (progn
    ;;(mouse-avoidance-mode 'animate)
    (setq scroll-step 1
          scroll-margin 1
          scroll-conservatively 10000)
    (setq display-time-day-and-date t)

    (setq display-time-24hr-format t)
    (display-time-mode t)))

(defun all-buffer-chinese-words-count ()
  "全buffer的字数统计,使用count的包装"
  (interactive)
  (let ((beg (point-min))
        (end (point-max)))
    (count beg end)))
(defun easypg-settings ()
  ;;; easypg，emacs 自带
  (require 'epa-file)
  (epa-file-enable)
  ;; 总是使用对称加密
  (setq epa-file-encrypt-to nil)
  ;; 允许缓存密码，否则编辑时每次保存都要输入密码
  (setq epa-file-cache-passphrase-for-symmetric-encryption t)
  ;; 允许自动保存
  (setq epa-file-inhibit-auto-save nil))

(defun calendar-setting ()
  (progn
    ;;(setq calendar-latitude +39.9)
    ;;(setq calendar-longitude +116.4)
    ;;(setq calendar-location-name "Beijing")
    (setq mark-holidays-in-calendar t)
    ;;打开calendar自动打开节日和生日列表
    (setq view-calendar-holidays-initially t)
    (setq calendar-week-start-day 1)
    (setq christian-holidays nil)
    (setq hebrew-holidays nil)
    (setq holiday-general-holidays
          '((holiday-fixed 1 1 "New Year's Day")
            (holiday-fixed 2 2 "Groundhog Day")
            (holiday-fixed 2 14 "Valentine's Day")
            (holiday-fixed 3 17 "St. Patrick's Day")
            (holiday-fixed 4 1 "April Fools' Day")
            (holiday-float 5 0 2 "Mother's Day")
            (holiday-float 5 1 -1 "Memorial Day")
            (holiday-float 6 0 3 "Father's Day")
            (holiday-fixed 7 4 "Independence Day")
            (holiday-float 9 1 1 "Labor Day")
            (holiday-float 10 1 2 "Columbus Day")
            (holiday-fixed 10 31 "Halloween")
            (holiday-fixed 11 11 "Veteran's Day")
            (holiday-float 11 4 4 "Thanksgiving")
            (holiday-fixed 1 1 "元旦")
            (holiday-fixed 3 8 "妇女节")
            (holiday-fixed 4 1 "愚人节")
            (holiday-fixed 4 11 "谁的生日")
            (holiday-fixed 5 1 "劳动节")
            (holiday-fixed 10 1 "国庆节")
            (holiday-fixed 12 25 "圣诞节")
            (holiday-float 5 0 2 "母亲节")
            (holiday-float 6 0 3 "父亲节")))))

(defun chinese-words-count (beg end)
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


(defun c-settings ()
  (progn
    (setq ecb-auto-activate 1)
    ;;(semantic-gcc-setup)
    (global-ede-mode 1)
    (semantic-mode 1)
    (require 'semantic/bovine/gcc)
    ;; Semantic
    (global-semantic-idle-completions-mode t)
    (global-semantic-decoration-mode t)
    (global-semantic-highlight-func-mode t)
    (global-semantic-show-unmatched-syntax-mode t)
    (require 'srecode)
    (global-srecode-minor-mode 1)))


(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))

(add-hook 'c-mode-hook
          '(lambda ()
             (setq ac-sources (append '(ac-source-semantic) ac-sources))
             (local-set-key (kbd "RET") 'newline-and-indent)
             (linum-mode t)
             (semantic-mode t)))

(add-hook 'c-mode-hook
          '(lambda ()
             (c-set-style "K&R")
             ;;(c-toggle-auto-state)
             (setq tab-width 8)
             (setq indent-tabs-mode t)
             (setq c-basic-offset 8)))
(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-style "K&R")
             ;;(c-toggle-auto-state)
             (setq tab-width 8)
             (setq indent-tabs-mode t)
             (setq c-basic-offset 8)))
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)

(defun my-ac-cc-mode-setup ()  
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))


(defun emms-settings ()
  (progn
    (require 'emms-setup)
    (emms-all)
    (emms-default-players)
    (setq emms-source-file-default-directory "~/Music/")))

(defun org-mode-settings ()
  (progn
    ;; FIX from http://lists.gnu.org/archive/html/emacs-orgmode/2013-04/msg00969.html 
    (setq org-beamer-outline-frame-options "")
    (setq org-log-done 'time)))

(defun org-latex-setting()
  (require 'org-latex)
  (require 'ox-latex)
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  (setq org-latex-minted-options
	'(("frame" "lines")
          ;;("bgcolor" "bg")
	  ("fontsize" "\\scriptsize")
	  ("linenos" "true")))
  
  ;;For org-mode version < 8
  ;;(setq org-export-latex-listings 'minted)  
  ;;(add-to-list 'org-export-latex-packages-alist '("" "minted"))
  ;;(setq org-export-latex-minted-options
  ;;	'(("frame" "lines")
  ;;("fontsize" "\\scriptsize")
  ;;	  ("linenos" "true")))
  (setq org-export-latex-hyperref-format "\\ref{%s}")
  (setq org-latex-preview-ltxpng-directory "~/")
  (setq org-latex-pdf-process
        (list "xelatex  -shell-escape -output-directory %o %f"
              ;;"bibtex %b"
              ;;"xelatex -interaction nonstopmode -output-directory %o %f"
              "xelatex  -shell-escape -output-directory %o %f")))

;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;;'( ;; other Babel languages
;;  (ditaa . t)
;;  (plantuml . t)
;;  (dot . t)
;;  (xxx . t)
;;)
;;)
(elpy-enable)
(jedi:setup)
;;(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)                 ; optional
;;(setq jedi:get-in-function-call-delay 500)


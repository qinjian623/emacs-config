;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;
;; remember this directory

;;; Time-stamp: <qin 10/25/2012 19:30:52>


;;;Auto-install package
;;(when (not package-archive-contents)
;;  (package-refresh-contents))
;; Add in your own as you wish:
;;(require 'org-install)

;;; init.el ends here
;;session settings

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings org auto-complete clojure-mode paredit yasnippet win-switch windresize session)
 "A list of packages to ensure are installed at launch.")

;;; BEGIN[qinjian] Font settings from emacser.com
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

;;if it is in the x then set the font	
(if window-system
    (qiang-set-font
	 '("Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=14"
	 '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体")))


;; starter kit : C-+, C--
;; For Linux
;;(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
;;(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)
;; For Windows
;;(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
;;(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)
;;;END


;;;BEGIN [qinjian] highlight-tail settings
;; TODO Doesn't work yet.
;;(add-to-list 'load-path "~/.emacs.d/")
;;(require 'highlight-tail)
;;(setq highlight-tail-colors
;;      '(("#c1e156" . 0)
;;        ("#b8ff07" . 25)
;;        ("#00c377" . 60)))
;;;END



;;(autoload 'js2-mode "js2-mode" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;;BEGIN [qinjian]
;;Settings with different platforms:
(defun windows-nt-settings ()
  (progn
    (setq org-publish-base-dir "C:\\Documents and Settings\\qinjian\\My Documents\\GitHub\\qinjian623.github.com\\_org\\_posts")
    (setq org-publish-publishing-dir "C:\\Documents and Settings\\qinjian\\My Documents\\GitHub\\qinjian623.github.com\\_posts")
    (setq org-todo-dir "F:\\Dropbox\\TODO")))
(defun mac-os-settings ()
  (progn
    (setq org-publish-base-dir "/Users/qin/Documents/git/qinjian623.github.com/_org/_posts")
    (setq org-publish-publishing-dir "/Users/qin/Documents/git/qinjian623.github.com/_posts")
    (setq org-todo-dir "~/Dropbox/TODO")
    (setq mac-option-key-is-meta t)
    (setq display-battery-mode t)))
;;System dependent settings
(defun system-var-settings ()
  (progn
    (if (equal system-type 'windows-nt)
        (windows-nt-settings))
    (if (equal system-type 'darwin)
        (mac-os-settings))))
(system-var-settings)

(defun org-mode-settings ()
  (progn
    (setq org-log-done 'time)
    (setq org-publish-project-alist
          '(("blog"
             :base-directory org-publish-base-dir
             :base-extension "org"
             :publishing-directory org-publish-publishing-dir
             :recursive t
             ;;        :htmlized-source t
             :html-extension "html"
             :author-info nil
             :body-only t
             :table-of-contents nil)))
    (setq org-agenda-files (list org-todo-dir))))

(defun auto-complete-settings ()
  (require 'auto-complete-config)
  ;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4.20110207/dict/")
  (ac-config-default)
  ;;(setq ac-quick-help-height 10)
  (setq ac-quick-help-delay 0.1))


;; TODO semantic-ia not installed
;;(require 'cedet)
;;(require 'semantic-ia)
;; Enable EDE (Project Management) features
;;(global-ede-mode 1)
;;(semantic-load-enable-excessive-code-helpers)
;;(semantic-load-enable-semantic-debugging-helpers)
;; Enable SRecode (Template management) minor-mode.
;;(global-srecode-minor-mode 1)


;;;BEGIN [qinjian] Some global settings
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(defun global-key-setting ()
  (progn
    (global-set-key [C-tab] 'other-window)
    (global-set-key (kbd "RET") 'newline-and-indent)

    (global-set-key "\C-j" 'goto-line)
    (global-set-key "\C-z" 'undo)))

(defun global-views-setting ()
  (progn
    (load-file "~/.emacs.d/themes/cyberpunk.el")
    ;;(color-theme-cyberpunk)
    (load-file "~/.emacs.d/themes/color-theme-tangotango.el")
    (color-theme-tangotango)
    ;;(mouse-avoidance-mode 'animate)
    (setq scroll-step 1
          scroll-margin 1
          scroll-conservatively 10000)
    (display-time-mode t)
    (setq display-time-day-and-date t)
    (setq display-time-24hr-format t)
    (global-linum-mode 1)
    (tool-bar-mode -1)
    (menu-bar-mode -1)
    (scroll-bar-mode -1)
    (setq frame-title-format "%n%F/%b")))

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

(setq version-control 'never)
(setq make-backup-files nil)
;;hooks region
(defun common-mode-hooks()
  (auto-fill-mode -1)
  (toggle-truncate-lines -1)
  (hl-line-mode -1))

(defun add-common-mode-hooks (l)
  (dolist (item l)
    (add-hook item 'common-mode-hooks)))

(defun time-stamp-setting ()
  (progn
    ;;只要里在你得文档里有Time-stamp:的设置，就会自动保存时间戳
    (setq time-stamp-active t)
    (setq time-stamp-warn-inactive t)
    (setq time-stamp-format "%:u %02m/%02d/%04y %02H:%02M:%02S")
    (add-hook 'write-file-hooks 'time-stamp)))


;;add hooks
(defun add-common-mode-hooks (l)
  (dolist (item l)
    (add-hook item 'common-mode-hooks)))

(add-hook 'emacs-lisp-mode-hook
          '(lambda () (progn
                   (rainbow-delimiters-mode t)
                   (hl-line-mode -1))))
(add-common-mode-hooks '(
                         emacs-lisp-mode-hook
                         emacs-startup-hook
                         org-mode-hook))

(add-hook 'emacs-startup-hook
          (lambda ()
            (dolist (p my-packages)
              (when (not (package-installed-p p))
                (package-install p)))))

(time-stamp-setting)
(calendar-setting)


;;Clojure settings
(add-hook 'nrepl-interaction-mode-hook
          'nrepl-turn-on-eldoc-mode)

(add-hook 'nrepl-mode-hook
          'nrepl-turn-on-eldoc-mode)

(defun ac-nrepl-settings ()
  (progn
    (require 'ac-nrepl)
    (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
    (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
    (eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))))

;;This is for the auto-complete-clang
;;TODO 
(defun auto-complete-clang-settings ()
  (progn
    (add-to-list 'load-path "~/.emacs.d/libs")
    (require 'auto-complete-clang)
    (setq ac-clang-auto-save t)
    (setq ac-auto-start t)
    (setq ac-quick-help-delay 0.5)
    (define-key ac-mode-map  [(control tab)] 'auto-complete)
    (my-ac-config)))

;; (ac-set-trigger-key "TAB")  
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)  
(defun my-ac-config ()  
  (setq ac-clang-flags  
        (mapcar(lambda (item)(concat "-I" item))  
               (split-string  
                "  
 /usr/include/c++/4.4  
 /usr/include/c++/4.4/i486-linux-gnu  
 /usr/include/c++/4.4/backward  
 /usr/local/include  
 /usr/lib/gcc/i486-linux-gnu/4.4.5/include  
 /usr/lib/gcc/i486-linux-gnu/4.4.5/include-fixed  
 /usr/include/i486-linux-gnu  
 /usr/include  
")))  
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))  
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)  
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)  
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)  
  (add-hook 'css-mode-hook 'ac-css-mode-setup)  
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)  
  (global-auto-complete-mode t))

(defun my-ac-cc-mode-setup ()  
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))  
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)  
;; ac-source-gtags  
(defun global-setting ()
  (progn (setq-default ispell-program-name "aspell")
         (ac-flyspell-workaround)
         (global-key-setting)
         (global-views-setting)
         (setq ring-bell-function (lambda ()(message "Bing!")))))

(add-hook 'after-init-hook
          `(lambda ()
             ;; remember this directory
             (setq starter-kit-dir
                   ,(file-name-directory (or load-file-name (buffer-file-name))))
             ;; load up the starter kit
             (require 'org)
             (org-babel-load-file (expand-file-name "starter-kit.org" starter-kit-dir))
             (starter-kit-load "lisp")
             (auto-complete-settings)
             (global-setting)
             (ac-nrepl-settings)
             ;; If setting function does not work properly, Just put it at the end. 
             (auto-complete-clang-settings)
             (require 'session)
             (session-initialize)
             (load "desktop")
             (desktop-load-default)
             (desktop-read)
             (ac-flyspell-workaround)))


(add-hook 'emacs-lisp-mode-hook
          '(lambda () (progn
                    (rainbow-delimiters-mode t)
                    (hl-line-mode -1))))

(desktop-save-mode t)

;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;;'( ;; other Babel languages
;;  (ditaa . t)
;;  (plantuml . t)
;;  (dot . t)
;;  (xxx . t)
;;)
;;)


(require 'org-latex)
(setq org-export-latex-listings 'minted)
(add-to-list 'org-export-latex-packages-alist '("" "minted"))
(setq org-export-latex-minted-options
      '(("frame" "lines")
        ("fontsize" "\\scriptsize")
        ("linenos" "true")))
(setq org-export-latex-hyperref-format "\\ref{%s}")

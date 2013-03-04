;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;
;; remember this directory

;;; Time-stamp: <qin 10/25/2012 19:30:52>

;;; BEGIN 
;;; BUGFIXED region
;;Copy this from org 7.8.11 missed from 7.9.* REASON: hu knows...
(defun org-strip-protective-commas (beg end)
  "Strip protective commas between BEG and END in the current buffer."
  (interactive "r")
  (save-excursion
    (save-match-data
      (goto-char beg)
      (let ((front-line (save-excursion
                          (re-search-forward
                           "[^[:space:]]" end t)
                          (goto-char (match-beginning 0))
                          (current-column))))
        (while (re-search-forward "^[ \t]*\\(,\\)\\([*]\\|#\\+\\)" end t)
          (goto-char (match-beginning 1))
          (when (= (current-column) front-line)
            (replace-match "" nil nil nil 1)))))))

(defun org-babel-noweb-p (params context)
  (let* (intersect
         (intersect (lambda (as bs)
                       (when as
                         (if (member (car as) bs)
                             (car as)
                           (funcall intersect (cdr as) bs))))))
    (funcall intersect (case context
                         (:tangle '("yes" "tangle" "no-export" "strip-export"))
                         (:eval   '("yes" "no-export" "strip-export" "eval"))
                         (:export '("yes")))
             (split-string (or (cdr (assoc :noweb params)) "")))))

(defun org-unescape-code-in-region (beg end)
  "Un-escape lines between BEG and END.
 Un-escaping happens by removing the first comma on lines starting
 with \",*\", \",#+\", \",,*\" and \",,#+\"."
  (interactive "r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "^[ \t]*,?\\(,\\)\\(?:\\*\\|#\\+\\)" end t)
      (replace-match "" nil nil nil 1))))

;;TODO[DONE] bug-fix for the org-find-library-dir
(defmacro org-find-library-dir (library)
  `(file-name-directory (locate-library ,library)))
;;;END

;;;Auto-install package
;;(when (not package-archive-contents)
;;  (package-refresh-contents))
;; Add in your own as you wish:



;;(require 'org-install)
(setq starter-kit-dir
      (file-name-directory (or load-file-name (buffer-file-name))))
;; load up the starter kit
(org-babel-load-file (expand-file-name "starter-kit.org" starter-kit-dir))
;;(starter-kit-load "lisp")
;;; init.el ends here

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings org auto-complete clojure-mode paredit yasnippet win-switch windresize)
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

(qiang-set-font
 '("Microsoft Yahei" "Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=17"
 '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))

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
(defun mac-os-settings()
  (progn
    (setq org-publish-project-alist
          '(("blog"
             :base-directory "/Users/qin/Documents/git/qinjian623.github.com/_org/_posts"
             :base-extension "org"
             
             :publishing-directory "/Users/qin/Documents/git/qinjian623.github.com/_posts"
             :recursive t
             ;;        :htmlized-source t
             :html-extension "html"
             :author-info nil
             :body-only t
             :table-of-contents nil)))
    (setq mac-option-key-is-meta t)
    (setq org-agenda-files (list "~/Dropbox/TODO"))
    (setq display-battery-mode t)))
(defun windows-nt-settings ()
  (progn
    (setq org-publish-project-alist
          '(("blog"
             :base-directory "C:\\Documents and Settings\\qinjian\\My Documents\\GitHub\\qinjian623.github.com\\_org\\_post"
             :base-extension "org"
             :publishing-directory "C:\\Documents and Settings\\qinjian\\My Documents\\GitHub\\qinjian623.github.com\\_post"
             :recursive t
			
             ;;        :htmlized-source t
             :html-extension "html"
             :author-info nil
             :body-only t
             :table-of-contents nil)))
    (setq org-agenda-files (list "F:\\Dropbox\\TODO"))))


(defun org-mode-settings ()
  (setq org-log-done 'time))

(defun auto-complete-settings ()
  (require 'auto-complete-config)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4.20110207/dict/")
  (ac-config-default)
  (setq ac-quick-help-delay 0.1)
  (setq ac-quick-help-height 10))
(auto-complete-settings)

;; TODO semantic-ia not installed yet
;;(require 'cedet)
;;(require 'semantic-ia)
;; Enable EDE (Project Management) features
;;(global-ede-mode 1)
;;(semantic-load-enable-excessive-code-helpers)
;;(semantic-load-enable-semantic-debugging-helpers)
;; Enable SRecode (Template management) minor-mode.
;;(global-srecode-minor-mode 1)


;;;BEGIN [qinjian] Some global settings
;;For Chinese Tokens
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(defun global-key-setting ()
  (progn
    (global-set-key [C-tab] 'other-window)
    (global-set-key "\C-m" 'set-mark-command)
    (global-set-key "\C-j" 'goto-line)
    (global-set-key "\C-z" 'undo)))

(defun global-views-setting ()
  (progn
    (load-file "~/.emacs.d/themes/cyberpunk.el")
    (color-theme-cyberpunk)
    (load-file "~/.emacs.d/themes/color-theme-tangotango.el")
    ;;(color-theme-tangotango)

    (mouse-avoidance-mode 'animate)
    (setq scroll-step 1
          scroll-margin 1
          scroll-conservatively 10000)
    (display-time-mode t)
    (setq display-time-day-and-date t)
    (setq display-time-24hr-format t)
    (global-linum-mode 1)
    (tool-bar-mode -1)
    (menu-bar-mode t)
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

;;defun color-theme-setting ()
;;now throw the file intro src/ ,will be added auto by start-kit
;;(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
;;(require 'color-theme)
;;(color-theme-initialize)
;;(color-theme-gnome2))

;;add hooks 
(add-common-mode-hooks '(
                         emacs-lisp-mode-hook
                         emacs-startup-hook
                         org-mode-hook))

(add-hook 'emacs-startup-hook
          (lambda ()
            (dolist (p my-packages)
              (when (not (package-installed-p p))
                (package-install p)))))

(global-key-setting)
(global-views-setting)

(time-stamp-setting)
;;(color-theme-setting)
(calendar-setting)

;;System dependent settings
(if (equal system-type 'windows-nt)
    (windows-nt-settings))
(if (equal system-type 'darwin)
    (mac-os-settings))


;;Clojure settings
(add-hook 'nrepl-interaction-mode-hook
          'nrepl-turn-on-eldoc-mode)

(add-hook 'nrepl-mode-hook
          'nrepl-turn-on-eldoc-mode)

(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))


;;;Common mode
(defun add-common-mode-hooks (l)
  (dolist (item l)
    (add-hook item 'common-mode-hooks)))

(add-common-mode-hooks '(
                         emacs-lisp-mode-hook
                         emacs-startup-hook
                         org-mode-hook))

(add-hook 'emacs-lisp-mode-hook
          '(lambda () (progn
                   (rainbow-delimiters-mode t)
                   (hl-line-mode -1))))

				   
;;Sounds useless
(global-set-key (kbd "RET") 'newline-and-indent)
(setq ring-bell-function
      (lambda ()
        (message "Bing!")))

		
;;Fly-make
(setq-default ispell-program-name "aspell")
(ac-flyspell-workaround)

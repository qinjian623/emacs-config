;;; qin.el --- Personal Configuration
;;; Commentary:
;; Copyright (C) 2014 Jian QIN
;;; Code:


(add-to-list 'load-path "~/.emacs.d/personal/")
(load "jec.python")
(load "jec.cnc++")
(load "jec.globalmode")
(load "jec.ac")
(load "jec.el")
(load "jec.binding")
(load "jec.helm")
(load "jec.fonts")
(load "jec.clojure")
(load "jec.ui.el")




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
    (setq display-time-day-and-date t)))

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

;; (defun calendar-setting ()
;;   (progn
;;     ;;(setq calendar-latitude +39.9)
;;     ;;(setq calendar-longitude +116.4)
;;     ;;(setq calendar-location-name "Beijing")
;;     (setq mark-holidays-in-calendar t)
;;     ;;打开calendar自动打开节日和生日列表
;;     (setq view-calendar-holidays-initially t)
;;     (setq calendar-week-start-day 1)
;;     (setq christian-holidays nil)
;;     (setq hebrew-holidays nil)
;;     (setq holiday-general-holidays
;;           '((holiday-fixed 1 1 "New Year's Day")
;;             (holiday-fixed 2 2 "Groundhog Day")
;;             (holiday-fixed 2 14 "Valentine's Day")
;;             (holiday-fixed 3 17 "St. Patrick's Day")
;;             (holiday-fixed 4 1 "April Fools' Day")
;;             (holiday-float 5 0 2 "Mother's Day")
;;             (holiday-float 5 1 -1 "Memorial Day")
;;             (holiday-float 6 0 3 "Father's Day")
;;             (holiday-fixed 7 4 "Independence Day")
;;             (holiday-float 9 1 1 "Labor Day")
;;             (holiday-float 10 1 2 "Columbus Day")
;;             (holiday-fixed 10 31 "Halloween")
;;             (holiday-fixed 11 11 "Veteran's Day")
;;             (holiday-float 11 4 4 "Thanksgiving")
;;             (holiday-fixed 1 1 "元旦")
;;             (holiday-fixed 3 8 "妇女节")
;;             (holiday-fixed 4 1 "愚人节")
;;             (holiday-fixed 4 11 "谁的生日")
;;             (holiday-fixed 5 1 "劳动节")
;;             (holiday-fixed 10 1 "国庆节")
;;             (holiday-fixed 12 25 "圣诞节")
;;             (holiday-float 5 0 2 "母亲节")
;;             (holiday-float 6 0 3 "父亲节")))))

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

(provide 'qin)
;;; qin.el ends here


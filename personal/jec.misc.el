;;; jec.misc.el --- 杂七杂八

;; Copyright (C) 2014 Jian QIN
;;
;;; Commentary:
;; 无
;;; Code:

(defun emms-settings ()
  (progn
    (require 'emms-setup)
    (emms-all)
    (emms-default-players)
    (setq emms-source-file-default-directory "~/Music/")))
(emms-settings)

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
(easypg-settings)

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

(provide 'jec.misc)
;;; jec.misc.el ends here

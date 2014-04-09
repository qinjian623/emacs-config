(defvar
  qj-english-fonts
  '("Courier New" "Courier 10 Pitch" "Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" ))

(defvar
  qj-chinese-fonts
  '( "文泉驿等宽微米黑" "SimSun" "Hei" "Microsoft Yahei"   "黑体" "新宋体" "宋体"))

(defvar qj-font-size  ":pixelsize=18")

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


(defun all-buffer-chinese-words-count ()
  "全buffer的字数统计,使用count的包装"
  (interactive)
  (let ((beg (point-min))
        (end (point-max)))
    (count beg end)))

(defun global-misc-settings ()
  (setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
  (setq sentence-end-double-space nil)
  (setq default-buffer-file-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq version-control 'never)
  (setq make-backup-files nil))

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

(defun switch-window-setting()
  (require 'switch-window)
  (setq switch-window-shortcut-style 'qwerty))

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

(defun time-stamp-setting ()
  (progn
    ;;只要里在你得文档里有Time-stamp:的设置，就会自动保存时间戳
    (setq time-stamp-active t)
    (setq time-stamp-warn-inactive t)
    (setq time-stamp-format "%:u %02m/%02d/%04y %02H:%02M:%02S")
    (add-hook 'write-file-hooks 'time-stamp)))

(provide 'qj-misc)



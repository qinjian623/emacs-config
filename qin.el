;;;
;;;
;;;

(golden-ratio-mode)
(yas-global-mode)
(setq sentence-end-double-space nil)

;;; Coding settings
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;; UI settings.
(load-theme 'deeper-blue)
(nyan-mode)
(global-linum-mode t)
(setq frame-title-format "%n%F/%b")
(setq ring-bell-function (lambda ()(message "Bing!")))

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

;;; Spell check
(setq-default ispell-program-name "aspell")
(ac-flyspell-workaround)
(ispell-change-dictionary "american" t)

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



;;; jec.ac.el --- 自定义的键绑定

;; Copyright (C) 2014 Jian QIN
;;
;;; Commentary:
;; 无
;;; Code:

(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;; TODO Need to check what the sk have done for us.
(global-set-key (kbd "<f11>") 'toggle-fullscreen)
(global-set-key (kbd "<f9>") 'smart-compile)
(global-set-key "\C-z" 'undo-tree-undo)
(global-set-key (kbd "RET") 'newline-and-indent)

(provide 'jec.binding)

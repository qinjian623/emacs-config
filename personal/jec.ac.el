;;; jec.ac.el --- Auto Complete的配置

;; Copyright (C) 2014 Jian QIN
;;
;;; Commentary:
;; 无
;;; Code:

;;(global-auto-complete-mode)
(setq ac-menu-height 10)

;; 统一上下移动的快捷键
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

(provide 'jec.ac.el)
;;; jec.ac.el ends here

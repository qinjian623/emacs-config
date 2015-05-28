;;; jec.ui.el --- UI配置

;; Copyright (C) 2014 Jian QIN
;;
;;; Commentary:
;; 无
;;; Code:

(case window-system
  ((x w32) (nyan-mode)))
(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq ring-bell-function (lambda ()(message "Bing!")))
(setq scroll-step 1
      scroll-margin 1
      scroll-conservatively 10000)


(provide 'jec.ui)

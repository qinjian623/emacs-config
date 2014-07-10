;;; jec.ui.el --- UI配置

;; Copyright (C) 2014 Jian QIN
;;
;;; Commentary:
;; 无
;;; Code:

(load-theme 'deeper-blue)
(case window-system
  ((x w32) (nyan-mode)))
(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))
(setq ring-bell-function (lambda ()(message "Bing!")))
(setq scroll-step 1
      scroll-margin 1
      scroll-conservatively 10000)


(provide 'jec.ui)
;;; jec.ui.el ends here

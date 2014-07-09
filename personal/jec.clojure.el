;;; jec.clojure.el --- Clojure设置

;; Copyright (C) 2014 Jian QIN
;;
;;; Commentary:
;; TODO 尚未进行配置和检查
;;; Code:

(defun ac-nrepl-settings ()
  (progn
    (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
    (add-hook 'nrepl-mode-hook
              'nrepl-turn-on-eldoc-mode)

    (add-hook 'nrepl-interaction-mode 'ac-nrepl-setup)
    (add-hook 'nrepl-interaction-mode-hook
              'nrepl-turn-on-eldoc-mode)
    (eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))))
(ac-nrepl-settings)

(provide 'jec.clojure.el)
;;; jec.clojure.el ends here

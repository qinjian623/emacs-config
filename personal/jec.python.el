;;; jec.python.el --- 用于构建Python开发环境的配置

;; Copyright (C) 2014 Jian QIN
;;
;;; Commentary:
;; 无
;;; Code:

;; 确保同时检查PEP8格式，虽然默认设置也会优先使用flake8
;;(setq python-check-command "flake8")

;; 默认会调用flymake的minor mode，但是我们已经使用flycheck作为检查器了
;; (setq elpy-default-minor-modes
;;       '(eldoc-mode
;;         highlight-indentation-mode
;;         yas-minor-mode
;;         auto-complete-mode))

;;(elpy-enable)
;; 关闭modeline上太多的显示，占用空间
;;(elpy-clean-modeline)

;; Jedi的设置，可以同时使用Jedi
;;(add-hook 'python-mode-hook 'jedi:setup)

;; 多加入两个ac源，方便代码
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             ;;(add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)
;;             (add-to-list 'ac-sources 'ac-source-yasnippet)))

;;(setq jedi:complete-on-dot t)                 ; optional
;;(setq jedi:get-in-function-call-delay 500)

(provide 'jec.python)
;;; jec.python.el ends here

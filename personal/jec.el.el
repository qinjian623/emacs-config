;;; jec.ac.el --- Emacs Lisp的配置

;; Copyright (C) 2014 Jian QIN
;;
;;; Commentary:
;; 无
;;; Code:
(require 'jec.ac)
(require 'auto-complete-config)

(add-hook 'emacs-lisp-mode-hook
          '(lambda () (progn
                    (rainbow-delimiters-mode t)
                    (ac-emacs-lisp-mode-setup)
                    (paredit-mode 1)
                    ;; ac-emacs-lisp-mode-setup 中没有文件的补全
                    (add-to-list 'ac-sources 'ac-source-filename))))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(define-key emacs-lisp-mode-map (kbd "M-n") 'forward-sexp)
(define-key emacs-lisp-mode-map (kbd "M-p") 'backward-sexp)

(provide 'jec.el)
;;; jec.el.el ends here

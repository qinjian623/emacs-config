
;;; jec.modes.el --- 所有的全局开启的模式
;; Copyright (C) 2015 Jian QIN
;;
;;; Commentary:
;; 无
;;; Code:

;; Global modes
(global-linum-mode t)
(global-company-mode)
(rainbow-delimiters-mode 1)
(global-flycheck-mode)
(global-undo-tree-mode)
(yas-global-mode)
(auto-fill-mode -1)
;;(global-auto-complete-mode)
(flyspell-prog-mode)
(golden-ratio-mode)

;; golden-ratio不需要的几个模式
(setq golden-ratio-exclude-modes
      '("ediff-mode"
        "gdb-locals-mode"
        "gdb-breakpoints-mode"
        "gdb-frames-mode"
        "gud-mode"
        "gdb-inferior-io-mode"
        "magit-log-mode"
        "magit-reflog-mode"
        "magit-status-mode"
        "eshell-mode"
        "dired-mode"))

;; Emacs Lisp
(add-hook 'emacs-lisp-mode-hook
          '(lambda () (progn
			(paredit-mode 1)
			(rainbow-delimiters-mode t)
			;;(ac-emacs-lisp-mode-setup)
			;; (add-to-list 'ac-sources 'ac-source-filename)
			)))
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(define-key emacs-lisp-mode-map (kbd "M-n") 'forward-sexp)
(define-key emacs-lisp-mode-map (kbd "M-p") 'backward-sexp)

(add-hook 'org-mode-hook
          (lambda ()
            (auto-fill-mode -1)
            (hl-line-mode -1)
            (toggle-truncate-lines -1)))

(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)
            (auto-fill-mode -1)
            (hl-line-mode -1)
            (toggle-truncate-lines -1)))

;; 编码统一默认使用utf-8
(setq default-buffer-file-coding-system 'utf-8)
(setq prefer-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;; 拼写检查
;; TODO auto-correct short key
(defun global-misc-settings ()
  (progn
    (setq-default ispell-program-name "aspell")
    ;;(ac-flyspell-workaround)
    (ispell-change-dictionary "american" t)
    (require 'flycheck-tip)
    (flycheck-tip-use-timer 'verbose)))

(global-misc-settings)

(provide 'jec.modes)
;;; jec.modes.el ends here

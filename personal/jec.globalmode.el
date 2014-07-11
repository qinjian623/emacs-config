;;; jec.globalmode.el --- 所有的全局开启的模式

;; Copyright (C) 2014 Jian QIN
;;
;;; Commentary:
;; 无
;;; Code:

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

(global-undo-tree-mode)
(global-auto-complete-mode)
(global-flycheck-mode)
(global-linum-mode t)
(flyspell-prog-mode)
(golden-ratio-mode)
(yas-global-mode)



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
            (toggle-truncate-lines -1)
            (number-font-lock-mode)))

;; TODO Do we need this?
(setq sentence-end-double-space nil)
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")

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

(provide 'jec.globalmode)
;;; jec.globalmode.el ends here

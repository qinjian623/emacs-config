;;; jec.python.el --- C/C++的配置

;; Copyright (C) 2014 Jian QIN
;;
;;; Commentary:
;; 无
;;; Code:

;;; 利用命令来获得库的位置，方便clang调用：echo "" | g++ -v -x c++ -E -
(setq ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item))
              (split-string
               "
 /usr/include/c++/4.8
 /usr/include/x86_64-linux-gnu/c++/4.8
 /usr/include/c++/4.8/backward
 /usr/lib/gcc/x86_64-linux-gnu/4.8/include
 /usr/local/include
 /usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed
 /usr/include/x86_64-linux-gnu
 /usr/include
")))

;; 两者共用配置
(defun c/c++-setting ()
  "C/C++ 模式共用的配置."
  (if jec.cnc++.async
      (progn
        (message "Using auto-complete-clang-async")
        (require 'auto-complete-clang-async)
        (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
        (ac-clang-launch-completion-process)
        (setq ac-sources '(ac-source-semantic
                           ac-source-clang-async
                           ac-source-yasnippet
                           ac-source-gtags
                           ac-source-filename))

        )
    (progn
      (message "Using auto-complete-clang")
      (require 'auto-complete-clang)
      (setq ac-sources '(ac-source-semantic
                         ac-source-clang
                         ac-source-yasnippet
                         ac-source-gtags
                         ac-source-filename))))
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8)
  ;; 必须重置表，否则多余的列表会影响结果，这些足够使用
  ;;; Already set by sk.
  ;;(local-set-key (kbd "RET") 'newline-and-indent)
  ;;(linum-mode t)
  (semantic-mode t)
  (c-toggle-auto-state)
  )

(add-hook 'c-mode-hook
          'c/c++-setting)
(add-hook 'c++-mode-hook
          'c/c++-setting)

;;; TODO 基本无作用的内容
;; (defun my-cedet-hook ()
;;   (local-set-key [(control return)] 'semantic-ia-complete-symbol)
;;   (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;;   (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;   (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))

;; (add-hook 'c-mode-common-hook 'my-cedet-hook)

;; (defun c-settings ()
;;   (progn
;;     (setq ecb-auto-activate 1)
;;     ;;(semantic-gcc-setup)
;;     (global-ede-mode 1)
;;     (semantic-mode 1)
;;     (require 'semantic/bovine/gcc)
;;     ;; semantic
;;     (global-semantic-idle-completions-mode t)
;;     (global-semantic-decoration-mode t)
;;     (global-semantic-highlight-func-mode t)
;;     (global-semantic-show-unmatched-syntax-mode t)
;;     (require 'srecode)
;;     (global-srecode-minor-mode 1)))

(provide 'jec.cnc++)
;;; jec.cnc++.el ends here


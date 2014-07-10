;;; jec.elpa.el --- Elpa配置

;; Copyright (C) 2014 Jian QIN
;;
;;; Commentary:
;; 无
;;; Code:


(setq package-archives
      '(("gnu"         . "http://elpa.gnu.org/packages/")
        ("org"         . "http://orgmode.org/elpa/")
        ("melpa"       . "http://melpa.milkbox.net/packages/")
        ("marmalade"   . "http://marmalade-repo.org/packages/")))
(package-initialize)

(setq starter-kit-packages
      (list
       'ac-nrepl
       'ace-jump-mode
       'ace-link
       'ace-window
       'auto-complete
       'auto-complete-clang
       'cider
       'clojure-mode
       'concurrent
       'ctable
       'cyberpunk-theme
       'dash
       'deferred
       'direx
       'elisp-slime-nav
       'elpy
       'emacs-eclim
       'emms
       'epc
       'epl
       'f
       'find-file-in-project
       'flycheck
       'flycheck-tip
       'fuzzy
       'ggtags
       'gh
       'gist
       'git-commit-mode
       'git-rebase-mode
       'golden-ratio
       'helm
       'helm-itunes
       'helm-orgcard
       'helm-package
       'helm-pydoc
       'helm-themes
       'highlight-indentation
       'idle-highlight-mode
       'ido-ubiquitous
       'idomenu
       'iedit
       'insert-shebang
       'jedi
       'jedi-direx
       'logito
       'magit
       'makey
       'noflet
       'nose
       'number-font-lock-mode
       'nyan-mode
       'org
       'paredit
       'parent-mode
       'pcache
       'pkg-info
       'popup
       'pos-tip
       'python-environment
       'pyvenv
       'rainbow-delimiters
       's
       'smart-compile
       'smex
       'starter-kit
       'starter-kit-bindings
       'starter-kit-eshell
       'starter-kit-lisp
       'undo-tree
       'yasnippet))

(provide 'jec.elpa)
;;; jec.elpa ends here

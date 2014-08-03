;;; init.el --- Personal Configuration
;;; Commentary:
;; Copyright (C) 2014 Jian QIN
;;; Code:

(add-to-list 'load-path "~/.emacs.d/personal/")

(require 'jec.elpa)
(require 'jec.ac)
(require 'jec.ui)
(require 'jec.helm)
(require 'jec.fonts)

(require 'jec.globalmode)
(require 'jec.binding)

(require 'jec.python)
(require 'jec.el)
(require 'jec.cnc++)

(add-hook 'after-init-hook
          `(lambda ()
             (setq package-user-dir "~/.emacs.d/elpa/")
             (starter-kit-load "starter-kit-lisp.org")
             (starter-kit-load "starter-kit-python.org")
             (starter-kit-load "starter-kit-yasnippet.org")))
(load "~/.emacs.d/sk/init.el")

(provide 'init)
;;; init.el ends here


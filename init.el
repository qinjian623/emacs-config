;;; init.el --- Personal Configuration
;;; Commentary:
;; Copyright (C) 2014 Jian QIN
;;; Code:

(add-to-list 'load-path "~/.emacs.d/personal/")
(setq httpd-port 8018)

(setq package-load-list '((elpy "1.4.2") all))
(require 'jec.elpa)
(require 'jec.ac)
(require 'jec.ui)
(require 'jec.helm)
(require 'jec.fonts)

(require 'jec.globalmode)
(require 'jec.binding)

(require 'jec.org)
(require 'jec.python)
(require 'jec.el)
(require 'jec.cnc++)

(add-hook 'after-init-hook
          `(lambda ()
             (setq package-user-dir "~/.emacs.d/elpa/")
             (package-initialize)
             (starter-kit-load "starter-kit-lisp.org")
             (starter-kit-load "starter-kit-python.org")
             (starter-kit-load "starter-kit-yasnippet.org")))

(load "~/.emacs.d/sk/init.el")
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

(provide 'init)
;;; init.el ends here


;; LISP settings
(add-hook 'emacs-lisp-mode-hook
          '(lambda () (progn
                    (rainbow-delimiters-mode t)
                    (hl-line-mode -1))))

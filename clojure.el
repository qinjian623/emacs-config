(require 'auto-complete-clang)
(require 'ac-nrepl)

(defun ac-nrepl-settings ()
  (progn
    (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
    (add-hook 'nrepl-mode-hook
              'nrepl-turn-on-eldoc-mode)

    (add-hook 'nrepl-interaction-mode 'ac-nrepl-setup)
    (add-hook 'nrepl-interaction-mode-hook
              'nrepl-turn-on-eldoc-mode)
    (eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))))


(provide 'qj-clojure)



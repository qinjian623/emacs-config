;; C/C++ language settings
(defun c-settings ()
  (progn
    (setq ecb-auto-activate 1)
    ;;(semantic-gcc-setup)
    (global-ede-mode 1)
    (semantic-mode 1)
    (require 'semantic/bovine/gcc)
    ;; Semantic
    (global-semantic-idle-completions-mode t)
    (global-semantic-decoration-mode t)
    (global-semantic-highlight-func-mode t)
    (global-semantic-show-unmatched-syntax-mode t)
    (require 'srecode)
    (global-srecode-minor-mode 1)))


(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))

(add-hook 'c-mode-hook
          '(lambda ()
             (setq ac-sources (append '(ac-source-semantic) ac-sources))
             (local-set-key (kbd "RET") 'newline-and-indent)
             (linum-mode t)
             (semantic-mode t)))

(add-hook 'c-mode-hook
          '(lambda ()
             (c-set-style "K&R")
             ;;(c-toggle-auto-state)
             (setq tab-width 8)
             (setq indent-tabs-mode t)
             (setq c-basic-offset 8)))
(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-style "K&R")
             ;;(c-toggle-auto-state)
             (setq tab-width 8)
             (setq indent-tabs-mode t)
             (setq c-basic-offset 8)))
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)

(defun my-ac-cc-mode-setup ()  
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))

;; ac-source-gtags

(provide 'qj-cxx)



;;; This is your personal config variable
(setq starter-kit-dir "~/.emacs.d/starter-kit/")
(setq debug-on-error t)
(setq yas-snippet-dirs (list "~/.emacs.d/snippets"))
(defun customize-dir-settings ()
  (progn
    (setq package-user-dir "~/.emacs.d/elpa")))

;; Fonts settings
(setq
  qj-english-fonts
  '("Courier New" "Courier 10 Pitch" "Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" ))
(setq
  qj-chinese-fonts
  '( "文泉驿等宽微米黑" "SimSun" "Hei" "Microsoft Yahei"   "黑体" "新宋体" "宋体"))
(setq qj-font-size  ":pixelsize=18")


(defun auto-complete-settings ()
  (require 'auto-complete-config)
  ;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4.20110207/dict/")
  (ac-config-default)
  ;;(setq ac-quick-help-height 10)
  (setq ac-quick-help-delay 0.1))

(system-var-settings)
(global-misc-settings)
(fonts-settings)
(easypg-settings)
(calendar-setting)
(time-stamp-setting)

(defun mew-settings ()
  (autoload 'mew "mew" nil t)
  (autoload 'mew-send "mew" nil t)

  ;; Optional setup (Read Mail menu for Emacs 21):
  (if (boundp 'read-mail-command)
      (setq read-mail-command 'mew))
  
  ;; Optional setup (e.g. C-xm for sending a message):
  (autoload 'mew-user-agent-compose "mew" nil t)
  (if (boundp 'mail-user-agent)
      (setq mail-user-agent 'mew-user-agent))
  (if (fboundp 'define-mail-user-agent)
      (define-mail-user-agent
        'mew-user-agent
        'mew-user-agent-compose
        'mew-draft-send-message
        'mew-draft-kill
        'mew-send-hook))
  ;回复
  (setq mew-refile-guess-control
        '(mew-refile-guess-by-folder
          mew-refile-guess-by-alist)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defvar my-packages '())                          ;;
;;                                                   ;;
;; (add-hook 'emacs-startup-hook                     ;;
;;           (lambda ()                                  ;;
;;             (dolist (p my-packages)               ;;
;;               (when (not (package-installed-p p)) ;;
;;                 (package-install p)))))           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;TODO 
(defun auto-complete-clang-settings ()                       
  (progn                                                    
    (add-to-list 'load-path "~/.emacs.d/libs")              
    (require 'auto-complete-clang)                          
    (setq ac-clang-auto-save t)                             
    (setq ac-auto-start t)                                  
    (setq ac-quick-help-delay 0.5)                          
    (define-key ac-mode-map  [(control tab)] 'auto-complete)
    (my-ac-config)))                                        
(message "auto-complete settings")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun auto-complete-clang-async-settings ()                               ;;
;;   (progn                                                                   ;;
;;     (add-to-list 'load-path "~/.emacs.d/libs")                             ;;
;;     (require 'auto-complete-clang-async)                                   ;;
;;     (setq ac-auto-start t)                                                 ;;
;;     (defun ac-cc-mode-setup ()                                             ;;
;;       (setq ac-clang-complete-executable "~/.emacs.d/libs/clang-complete") ;;
;;       (setq ac-sources '(ac-source-clang-async))                           ;;
;;       (ac-clang-launch-completion-process))                                ;;
;;                                                                            ;;
;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;           ;;
;;     ;; (defun my-ac-config ()                                 ;;           ;;
;;     ;;   (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)     ;;           ;;
;;     ;;   (add-hook 'auto-complete-mode-hook 'ac-common-setup) ;;           ;;
;;     ;;   (global-auto-complete-mode t))                       ;;           ;;
;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;           ;;
;;     (my-ac-config)))                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (ac-set-trigger-key "TAB")  
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)  
(defun my-ac-config ()  
  (setq ac-clang-flags  
        (mapcar(lambda (item)(concat "-I" item))  
               (split-string  
                "  
 /usr/include/c++/4.4  
 /usr/include/c++/4.4/i486-linux-gnu  
 /usr/include/c++/4.4/backward  
 /usr/local/include  
 /usr/lib/gcc/i486-linux-gnu/4.4.5/include  
 /usr/lib/gcc/i486-linux-gnu/4.4.5/include-fixed  
 /usr/include/i486-linux-gnu  
 /usr/include
 /usr/include/c++/4.7
 /usr/include/x86_64-linux-gnu/c++/4.7/.
 /usr/include/c++/4.7/backward
 /usr/lib/gcc/x86_64-linux-gnu/4.7/include
 /usr/local/include
 /usr/lib/gcc/x86_64-linux-gnu/4.7/include-fixed
 /usr/include/x86_64-linux-gnu
 /usr/include
")))  
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))  
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)  
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)  
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)  
  (add-hook 'css-mode-hook 'ac-css-mode-setup)  
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)  
  (global-auto-complete-mode t))



(add-hook 'after-init-hook
          ;; If setting function does not work properly, Just put it at the end. 
          `(lambda ()
             (org-babel-load-file (expand-file-name "starter-kit.org" starter-kit-dir))
             (customize-dir-settings)
             (dolist (package starter-kit-packages)
               (starter-kit-install-if-needed package))
             (require 'yasnippet)
             (starter-kit-load "lisp")
             (message "lambda3")
             (auto-complete-settings)
             (message "lambda4")
	     (switch-window-setting)
             (global-setting)
             (ac-nrepl-settings)
             (auto-complete-clang-settings)
             ;;(auto-complete-clang-async-settings)
             (require 'session)
             (session-initialize)
             (ac-flyspell-workaround)
             (emms-settings)
             (c-settings)
             (load "desktop")
             (desktop-load-default)
             (org-mode-settings)
             (org-latex-setting)
             (message "ALL INIT FINISHED")
             (global-undo-tree-mode)))

(setq starter-kit-packages
      (list
       '4clojure
       'ac-nrepl
       'auto-complete
       'auto-complete-clang-async
       'cider
       'cl-lib
       'clojure-mode
       'color-theme
       'concurrent
       'ctable
       'dash
       'deferred
       'ecb
       'elisp-slime-nav
       'elpy
       'emms
       'epc
       'epl
       'find-file-in-project
       'flymake
       'fuzzy
       'geiser
       'git-commit-mode
       'git-rebase-mode
       'highlight-indentation
       'htmlize
       'idle-highlight-mode
       'idomenu
       'ido-ubiquitous
       'iedit
       'jedi
       'magit
       'markdown-mode
       'mew
       'nav
       'nose
       'nrepl
       'org
       'paredit
       'pkg-info
       'popup
       'rainbow-delimiters
       's
       'session
       'smart-compile
       'smex
       'sml-mode
       'ssh
       'switch-window
       'tabbar
       'tabbar-ruler
       'undo-tree
       'virtualenv
       'windresize
       'win-switch
       'yasnippet
       'yasnippet
       'zen-and-art-theme))


(provide 'qj-init)

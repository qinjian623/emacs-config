
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
             (auto-complete-settings)

             (auto-complete-clang-settings)
             ;;(auto-complete-clang-async-settings)
             (require 'session)
             (session-initialize)
             (ac-flyspell-workaround)
             (load "desktop")
             (desktop-load-default)
             (message "ALL INIT FINISHED")
             (global-undo-tree-mode)
             (personal-setting)))

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

(defun personal-setting ()
  (progn
    (add-to-list 'load-path "~/.emacs.d/personal/")
    (require 'qj-os)
    (require 'qj-misc)
    (require 'qj-global-settings)
    (require 'qj-clojure)
    (require 'qj-emms)
    (require 'qj-org)
    (require 'qj-cxx)
    (require 'qj-python)
    (org-latex-setting)
    (org-mode-settings)
    (c-settings)
    (emms-settings)
    (ac-nrepl-settings)
    (switch-window-setting)
    (global-settings)
    (system-var-settings)
    (global-misc-settings)
    (easypg-settings)
    (calendar-setting)
    (time-stamp-setting)))

(provide 'qj-init)

(defface 2048-2-face '((t (:foreground "red"))) "Face used for 2" :group '2048-game)
(defface 2048-4-face '((t (:foreground "orange"))) "Face used for 4" :group '2048-game)
(defface 2048-8-face '((t (:foreground "yellow"))) "Face used for 8" :group '2048-game)
(defface 2048-16-face '((t (:foreground "green"))) "Face used for 16" :group '2048-game)
(defface 2048-32-face '((t (:foreground "lightblue" :bold t))) "Face used for 32" :group '2048-game)
(defface 2048-64-face '((t (:foreground "lavender" :bold t))) "Face used for 64" :group '2048-game)
(defface 2048-128-face '((t (:foreground "SlateBlue" :bold t))) "Face used for 128" :group '2048-game)
(defface 2048-256-face '((t (:foreground "MediumVioletRed" :bold t))) "Face used for 256" :group '2048-game)
(defface 2048-512-face '((t (:foreground "tomato" :bold t))) "Face used for 512" :group '2048-game)
(defface 2048-1024-face '((t (:foreground "SkyBlue1" :bold t))) "Face used for 1024" :group '2048-game)
(defface 2048-2048-face '((t (:foreground "lightgreen" :bold t))) "Face used for 2048" :group '2048-game)

(defvar 2048-font-lock-keywords
  '(("\\<2\\>" 0 '2048-2-face)
    ("\\<4\\>" 0 '2048-4-face)
    ("\\<8\\>" 0 '2048-8-face)
    ("\\<16\\>" 0 '2048-16-face)
    ("\\<32\\>" 0 '2048-32-face)
    ("\\<64\\>" 0 '2048-64-face)
    ("\\<128\\>" 0 '2048-128-face)
    ("\\<256\\>" 0 '2048-256-face)
    ("\\<512\\>" 0 '2048-512-face)
    ("\\<1024\\>" 0 '2048-1024-face)
    ("\\<2048\\>" 0 '2048-2048-face)))

(defun sacha/2048-fontify ()
  (font-lock-add-keywords nil 2048-font-lock-keywords))

(defun sacha/2048-set-font-size ()
  (text-scale-set 5))
(add-hook '2048-mode-hook 'sacha/2048-fontify)
(add-hook '2048-mode-hook 'sacha/2048-set-font-size)
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

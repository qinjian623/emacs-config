;;hooks region
(defun common-mode-hooks()
  (auto-fill-mode -1)
  (toggle-truncate-lines -1)
  (hl-line-mode -1))

(defun add-common-mode-hooks (l)
  (dolist (item l)
    (add-hook item 'common-mode-hooks)))


(add-common-mode-hooks '(
                         emacs-lisp-mode-hook
                         emacs-startup-hook
                         org-mode-hook))

;; Fucniont global-settings will invoke all global-XX-settings below
(defun global-settings ()
  (progn (global-key-setting)
         (global-views-setting)))

(defun global-key-settings ()
  (progn
    ;; Not work yet.
    (global-set-key (kbd "C-.") 'flyspell-auto-correct-word)
    (global-set-key [C-.] 'flyspell-auto-correct-word)
    ;; Working well.
    (global-set-key (kbd "<f11>") 'toggle-fullscreen)
    (global-set-key [C-tab] 'other-window)
    (global-set-key (kbd "RET") 'newline-and-indent)
    (global-set-key "\C-j" 'goto-line)
    (global-set-key "\C-z" 'undo-tree-undo)
    (global-set-key (kbd "<f2>") 'find-filen)
    (global-set-key (kbd "<f9>") 'smart-compile)
    (global-set-key (kbd "<f5>") 'nav-toggle)))

;;; X-window settings
(defun x-window-settings ()
  (defun window-system-settings ()
    (progn
      (scroll-bar-mode -1)
      (font-settings)))
  (if window-system
      (window-system-settings)))

(defun nox-window-settings ()
  (progn
    (load-file "~/.emacs.d/themes/cyberpunk.el")
    (load-file "~/.emacs.d/themes/color-theme-tangotango.el")
    (color-theme-tangotango)
    (color-theme-cyberpunk)
    
    ;;(mouse-avoidance-mode 'animate)
    (setq scroll-step 1
          scroll-margin 1
          scroll-conservatively 10000)
    (setq display-time-day-and-date t)
    (setq display-time-24hr-format t)

    (display-time-mode t)
    (global-linum-mode t)
    (tool-bar-mode -1)
    (menu-bar-mode -1)
    (setq frame-title-format "%n%F/%b")))

(defun global-views-settings ()
  (progn
    (x-window-settings))
  
  )

(defun global-misc-settings ()
  (progn
    (setq-default ispell-program-name "aspell")
    (ac-flyspell-workaround)
    (ispell-change-dictionary "american" t)
    (setq ring-bell-function (lambda ()(message "Bing!")))))


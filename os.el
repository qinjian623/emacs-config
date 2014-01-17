(defun system-var-settings ()
  (progn
    (if (equal system-type 'windows-nt)
        (windows-nt-settings))
    (if (equal system-type 'darwin)
        (mac-os-settings))
    (if (equal system-type 'gnu/linux)
        (linux-settings))))

(defun mac-settings ()
  (progn
    (setq org-publish-project-alist
          '(("blog"
             :base-directory "/Users/qin/Documents/git/qinjian623.github.com/_orgs"
             :base-extension "org"
             :publishing-directory "/Users/qin/Documents/git/qinjian623.github.com/_posts"
             :publishing-function org-html-publish-to-html
             :recursive t
             :htmlized-source t
             :html-extension "html"
             :with-author nil
             :with-toc nil
             :section-number nil
             :author-info nil
             :body-only t
             :table-of-contents nil)))
    (setq org-agenda-dir "~/Dropbox/TODO")
    (setq mac-option-key-is-meta t)
    (setq display-battery-mode t)
    (defun toggle-fullscreen ()
      "Toggle full screen"
      (interactive)
      (set-frame-parameter
       nil 'fullscreen
       (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))))

(defun nt-settings ()
  (progn
    (setq org-publish-project-alist
          '(("blog"
             :base-directory "C:\\Documents and Settings\\qinjian\\My Documents\\GitHub\\qinjian623.github.com\\_orgs"
             :base-extension "org"
             :publishing-directory "C:\\Documents and Settings\\qinjian\\My Documents\\GitHub\\qinjian623.github.com\\_posts"
             :publishing-function org-html-publish-to-html
             :recursive t
             :htmlized-source t
             :html-extension "html"
             :with-author nil
             :with-toc nil
             :section-number nil
             :author-info nil
             :body-only t
             :table-of-contents nil)))
    (setq org-agenda-files "F:\\Dropbox\\TODO")))

(defun linux-settings ()
  (progn
    (setq org-publish-project-alist
          '(("blog"
             :base-directory "/home/qin/Documents/git/qinjian623.github.com/_orgs"
             :base-extension "org"
             :publishing-directory "/home/qin/Documents/git/qinjian623.github.com/_posts"
             :publishing-function org-html-publish-to-html
             :recursive t
             :htmlized-source t
             :html-extension "html"
             :with-author nil
             :with-toc nil
             :section-number nil
             :author-info nil
             :body-only t
             :table-of-contents nil)))
    (setq org-agenda-files (list "~/Dropbox/TODO"))
    (defun toggle-fullscreen ()
      "Toggle full screen"
      (interactive)
      (set-frame-parameter
       nil 'fullscreen
       (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))))

(provide qj-os)

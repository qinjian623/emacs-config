(defun org-mode-settings ()
  (progn
    ;; FIX from http://lists.gnu.org/archive/html/emacs-orgmode/2013-04/msg00969.html 
    (setq org-beamer-outline-frame-options "")
    (setq org-log-done 'time)))

(defun org-latex-setting()
  (require 'org-latex)
  (require 'ox-latex)
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  (setq org-latex-minted-options
	'(("frame" "lines")
          ;;("bgcolor" "bg")
	  ("fontsize" "\\scriptsize")
	  ("linenos" "true")))
  
  ;;For org-mode version < 8
  ;;(setq org-export-latex-listings 'minted)  
  ;;(add-to-list 'org-export-latex-packages-alist '("" "minted"))
  ;;(setq org-export-latex-minted-options
  ;;	'(("frame" "lines")
  ;;("fontsize" "\\scriptsize")
  ;;	  ("linenos" "true")))
  (setq org-export-latex-hyperref-format "\\ref{%s}")
  (setq org-latex-preview-ltxpng-directory "~/")
  (setq org-latex-pdf-process
        (list "xelatex  -shell-escape -output-directory %o %f"
              ;;"bibtex %b"
              ;;"xelatex -interaction nonstopmode -output-directory %o %f"
              "xelatex  -shell-escape -output-directory %o %f")))

;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;;'( ;; other Babel languages
;;  (ditaa . t)
;;  (plantuml . t)
;;  (dot . t)
;;  (xxx . t)
;;)
;;)

(provide 'qj-org)

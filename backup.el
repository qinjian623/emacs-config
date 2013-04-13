(defun org-strip-protective-commas (beg end)
  "Strip protective commas between BEG and END in the current buffer."
  (interactive "r")
  (save-excursion

    (save-match-data
      (goto-char beg)
      (let ((front-line (save-excursion
                          (re-search-forward
                           "[^[:space:]]" end t)
                          (goto-char (match-beginning 0))
                          (current-column))))
        (while (re-search-forward "^[ \t]*\\(,\\)\\([*]\\|#\\+\\)" end t)
          (goto-char (match-beginning 1))
          (when (= (current-column) front-line)
            (replace-match "" nil nil nil 1)
            )))))
  )
  
 (defun org-strip-protective-commas (beg end)
  "Strip protective commas between BEG and END in the current buffer."
  (interactive "r")
  (save-excursion

    (save-match-data
      (goto-char beg)
      (let ((front-line (save-excursion
                          (re-search-forward
                           "[^[:space:]]" end t)
                          (goto-char (match-beginning 0))
                          (current-column))))
        (while (re-search-forward "^[ \t]*\\(,\\)\\([*]\\|#\\+\\)" end t)
          (goto-char (match-beginning 1))
          (when (= (current-column) front-line)
            (replace-match "" nil nil nil 1)
            )))))
  )
  
  
  ;;; BEGIN 
;;; BUGFIXED region
;;Copy this from org 7.8.11 missed from 7.9.* REASON: hu knows...

(defun org-strip-protective-commas (beg end)
  "Strip protective commas between BEG and END in the current buffer."
  (interactive "r")
  (save-excursion

    (save-match-data
      (goto-char beg)
      (let ((front-line (save-excursion
                          (re-search-forward
                           "[^[:space:]]" end t)
                          (goto-char (match-beginning 0))
                          (current-column))))
        (while (re-search-forward "^[ \t]*\\(,\\)\\([*]\\|#\\+\\)" end t)
          (goto-char (match-beginning 1))
          (when (= (current-column) front-line)
            (replace-match "" nil nil nil 1)
            )))))
  )

(defun org-babel-noweb-p (params context)
  (let* (intersect
         (intersect (lambda (as bs)
                       (when as
                         (if (member (car as) bs)
                             (car as)
                           (funcall intersect (cdr as) bs))))))
    (funcall intersect (case context
                         (:tangle '("yes" "tangle" "no-export" "strip-export"))
                         (:eval   '("yes" "no-export" "strip-export" "eval"))
                         (:export '("yes")))
             (split-string (or (cdr (assoc :noweb params)) "")))))

(defun org-unescape-code-in-region (beg end)
  "Un-escape lines between BEG and END.
 Un-escaping happens by removing the first comma on lines starting
 with \",*\", \",#+\", \",,*\" and \",,#+\"."
  (interactive "r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "^[ \t]*,?\\(,\\)\\(?:\\*\\|#\\+\\)" end t)
      (replace-match "" nil nil nil 1))))

;;TODO[DONE] bug-fix for the org-find-library-dir
;;(defmacro org-find-library-dir (library)
;;  `(file-name-directory (locate-library ,library)))

;;;END

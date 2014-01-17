;; Emms Music Settings
(defun emms-settings ()
  (progn
    (require 'emms-setup)
    (emms-all)
    (emms-default-players)
    (setq emms-source-file-default-directory "~/Music/")))

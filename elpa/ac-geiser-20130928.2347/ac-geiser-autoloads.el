;;; ac-geiser-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ac-geiser-setup) "ac-geiser" "ac-geiser.el" (21465
;;;;;;  65035 501483 587000))
;;; Generated autoloads from ac-geiser.el

(defvar ac-source-geiser '((candidates . ac-source-geiser-candidates) (symbol . "g") (document . ac-geiser-documentation)) "\
Source for geiser completion")

(autoload 'ac-geiser-setup "ac-geiser" "\
Add the geiser completion source to the front of `ac-sources'.
This affects only the current buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("ac-geiser-pkg.el") (21465 65035 605055
;;;;;;  507000))

;;;***

(provide 'ac-geiser-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ac-geiser-autoloads.el ends here
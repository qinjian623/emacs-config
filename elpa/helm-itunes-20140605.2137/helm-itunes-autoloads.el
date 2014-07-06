;;; helm-itunes-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (helm-itunes) "helm-itunes" "helm-itunes.el" (21433
;;;;;;  3158 826428 507000))
;;; Generated autoloads from helm-itunes.el

(defvar helm-source-itunes-search '((name . "iTunes Search") (volatile) (delayed . 1) (multiline) (requires-pattern . 2) (candidates-process . helm-itunes-helm-search) (action ("Play Track" . helm-itunes-play-track))))

(autoload 'helm-itunes "helm-itunes" "\
Bring up a Spotify search interface in helm.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("helm-itunes-pkg.el") (21433 3158 903784
;;;;;;  28000))

;;;***

(provide 'helm-itunes-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; helm-itunes-autoloads.el ends here

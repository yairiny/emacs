;;; expectations-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (expectations-mode) "expectations-mode" "expectations-mode.el"
;;;;;;  (21111 6617 0 0))
;;; Generated autoloads from expectations-mode.el

(autoload 'expectations-mode "expectations-mode" "\
A minor mode for running expectations tests

\(fn &optional ARG)" t nil)

(defun expectations-maybe-enable nil "\
Enable expectations-mode and disable clojure-test-mode if
the current buffer contains a namespace with a \"test.\" bit on
it." (let ((ns (clojure-find-package))) (when (or (search "expectations." ns) (search "-expectations" ns)) (save-window-excursion (expectations-mode t) (clojure-test-mode 0)))))

(add-hook 'clojure-mode-hook 'expectations-maybe-enable)

;;;***

;;;### (autoloads nil nil ("expectations-mode-pkg.el") (21111 6617
;;;;;;  984216 0))

;;;***

(provide 'expectations-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; expectations-mode-autoloads.el ends here

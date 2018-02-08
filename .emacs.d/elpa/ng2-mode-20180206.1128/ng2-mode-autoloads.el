;;; ng2-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "ng2-html" "ng2-html.el" (23164 2224 578593
;;;;;;  601000))
;;; Generated autoloads from ng2-html.el

(autoload 'ng2-html-mode "ng2-html" "\
Major mode for Angular 2 templates

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.component.html\\'" . ng2-html-mode))

;;;***

;;;### (autoloads nil "ng2-mode" "ng2-mode.el" (23164 2224 582593
;;;;;;  610000))
;;; Generated autoloads from ng2-mode.el

(autoload 'ng2-mode "ng2-mode" "\
Activates the appropriate Angular 2-related mode for the buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "ng2-ts" "ng2-ts.el" (23164 2224 566593 572000))
;;; Generated autoloads from ng2-ts.el

(autoload 'ng2-ts-mode "ng2-ts" "\
Major mode for Angular 2 TypeScript

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.component.ts\\'" . ng2-ts-mode))

(add-to-list 'auto-mode-alist '("\\.service.ts\\'" . ng2-ts-mode))

;;;***

;;;### (autoloads nil nil ("ng2-mode-pkg.el") (23164 2224 590593
;;;;;;  630000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ng2-mode-autoloads.el ends here

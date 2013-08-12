;;; ruby-electric-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ruby-electric-mode) "ruby-electric" "ruby-electric.el"
;;;;;;  (21000 33566 811543 207000))
;;; Generated autoloads from ruby-electric.el

(autoload 'ruby-electric-mode "ruby-electric" "\
Toggle Ruby Electric minor mode.
With no argument, this command toggles the mode.  Non-null prefix
argument turns on the mode.  Null prefix argument turns off the
mode.

When Ruby Electric mode is enabled, an indented 'end' is
heuristicaly inserted whenever typing a word like 'module',
'class', 'def', 'if', 'unless', 'case', 'until', 'for', 'begin',
'do'. Simple, double and back quotes as well as braces are paired
auto-magically. Expansion does not occur inside comments and
strings. Note that you must have Font Lock enabled.

\(fn &optional ARG)" t nil)

(eval-after-load 'ruby-mode '(add-hook 'ruby-mode-hook 'ruby-electric-mode))

;;;***

;;;### (autoloads nil nil ("ruby-electric-pkg.el") (21000 33566 824300
;;;;;;  228000))

;;;***

(provide 'ruby-electric-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ruby-electric-autoloads.el ends here

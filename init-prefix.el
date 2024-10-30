;; Taken from https://github.com/ninrod/emacs-antiproxy.
(require 'package)

(setq package-enable-at-startup nil)
(setq package-archives '(("melpa" . "~/.emacs.d/elpa-mirror/melpa/")
                         ("org"   . "~/.emacs.d/elpa-mirror/org/")
                         ("gnu"   . "~/.emacs.d/elpa-mirror/gnu/")))
(package-initialize)

(unless (package-installed-p 'use-package) ; Bootstrap John Wigley's `use-package'
  (package-refresh-contents)
  (package-install 'use-package))

;; Disable check package signatures (needed as queue-0.2 signature has expired).
(setq package-check-signature nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of part taken from https://github.com/ninrod/emacs-antiproxy.
;; Customizations follow.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set whitespace's line width to big value to disable highlighting overly long lines.
(setq whitespace-line-column 500)

;; Avoid having the warnings buffer pop up.
(setq warning-minimum-level :error)

;; Disable the menu bar as it is unusable in this case.
(menu-bar-mode -1)

(make-variable-buffer-local 'company-backends)
(global-company-mode)

(defun my-c-mode-company-hook ()
  ;;(company-mode-on)
  (irony-mode t)
  (irony-cdb-autosetup-compile-options)
  (setq flycheck-checker 'irony)
  (flycheck-mode)
  ;(ycmd-mode t)
  (setq company-backends
        '(company-irony company-dabbrev-code company-gtags )))
;;'(company-c-headers company-irony company-dabbrev-code company-gtags )))

(defun my-py-mode-company-hook()
  (setq company-minimum-prefix-length 2))

(add-hook 'c-mode-common-hook 'my-c-mode-company-hook t)
(add-hook 'python-mode-hook 'my-py-mode-company-hook t)
(make-variable-buffer-local 'company-minimum-prefix-length)
(setq-default  company-minimum-prefix-length 3)
(setq company-dabbrev-downcase nil)
(setq company-auto-complete nil)

;;; Irony setup in windows:
;;; 1. download msvc llvm-clang
;;; 2. TDM-GCC compile irony-server
;;; 3. .clang_complete: --target=x86_64-w64-mingw32
(require 'company-irony)
(require 'flycheck-irony)
(flycheck-irony-setup)
(defun company-irony-prefix ()
  "Prefix-command handler for the company backend."
  (and buffer-file-name
       (or (not (company-in-string-or-comment))
           nil)
       (or (and (looking-back "\\(\\.\\|->\\|::\\|/\\)[_a_zA-Z0-9 \t]*")
                (company-grab-symbol-cons "\\.\\|->\\|::\\|/" 2))
           nil)))

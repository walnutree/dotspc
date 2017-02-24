(eval-when-compile (require 'cc-mode))
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "linux")))

(defun c-snug-fun (syntax pos)
 (let ((here (point)))
    (c-skip-ws-backward)
    (delete-region (point) here)
    '(before after)))

(defun my-c-mode-common-hook ()
  (local-set-key (kbd "M-n") 'forward-paragraph) ; add a key
  (local-set-key (kbd "M-p") 'backward-paragraph) ; add a key
  ;; other customizations
  (setq tab-width 8
        c-basic-offset 8
        indent-tabs-mode t)
  ;; we like auto-newline and hungry-delete
  ;;(c-toggle-auto-hungry-state 1)
  (which-function-mode t)
  (turn-on-auto-fill)
  ;;(flycheck-mode -1)
  ;(setq c-tab-always-indent 8)
  (setq c-tab-always-indent nil)

  (setq c-cleanup-list   '(brace-else-brace
         brace-elseif-brace
        defun-close-semi
        list-close-comma
        ))
  (setq c-hanging-braces-alist
        (append '(
                  (class-open . (after)) (defun-open . c-snug-fun)
                  (brace-list-intro . nil) (brace-list-close . nil)
                  (inline-open . nil)  (inline-close . nil)
                  (statement-cont . nil)
                  )
                c-hanging-braces-alist))
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-c++-mode-common-hook ()
  ;; other customizations
  (setq tab-width 8
        c-basic-offset 4
        indent-tabs-mode nil)
  )
(add-hook 'c++-mode-hook 'my-c++-mode-common-hook)

(defun my-asm-mode-hook ()
  ;; other customizations
  (setq tab-width 8
        indent-tabs-mode t)
  ;; we like auto-newline and hungry-delete
  (which-function-mode t)
  (turn-on-auto-fill)
  (setq show-trailing-whitespace t)
  (set-face-background 'trailing-whitespace "blue"))

(add-hook 'asm-mode-hook 'my-asm-mode-hook)
(defun my-ld-mode-hook ()
  (setq tab-width 8
        indent-tabs-mode t)
  (local-set-key (kbd "RET") 'newline-and-indent)
  (set (make-local-variable 'indent-line-function)
       'indent-to-left-margin)
  (setq show-trailing-whitespace t)
  (set-face-background 'trailing-whitespace "blue")
  )
(add-hook 'ld-script-mode-hook 'my-ld-mode-hook)

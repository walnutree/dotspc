(eval-when-compile (require 'dired))
(defun my-dired-mode-hook ()
  (define-key dired-mode-map "a" 'dired-sort-toggle-or-edit)
  (define-key dired-mode-map "f" nil)
  (define-key dired-mode-map "s" nil))

(add-hook 'dired-mode-hook #'my-dired-mode-hook t)

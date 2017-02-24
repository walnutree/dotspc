(setq gdb-command-name "gdb_SLES12")

(eval-when-compile (require 'gdb-mi))
(defun my-gdb-mi-hook()
  (company-mode -1)
  (setq gdb-many-windows nil))

(eval-after-load 'gdb-mi
  '(lambda()
     (setq gdb-many-windows nil)))
(add-hook 'gud-mode-hook #'my-gdb-mi-hook t)

(eval-when-compile (require 'cc-mode))
(defun ppp-c-mode-common-hook ()
  (let ((name buffer-file-name))
    (if (string-match "\\(/c4.*\\)\\|\\(/csx\\)\\|\\(/safe/catmerge\\)" name)
        (setq tab-width 4
              fill-column 120
              c-basic-offset 4
              indent-tabs-mode nil))))

(add-hook 'c-mode-common-hook 'ppp-c-mode-common-hook t)

(require 'keyfreq)
(setq keyfreq-excluded-commands
      '(self-insert-command
        org-self-insert-command
        abort-recursive-edit
        forward-char
        backward-char
        previous-line
        evil-next-visual-line
        evil-previous-visual-line
        evil-forward-char
        evil-backward-char
        next-line))
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(require 'compile)
(add-to-list 'auto-mode-alist '("build_errors\\.txt" . compilation-mode))
(defun my-refresh-compilation-mode ()
  (interactive)
  (goto-char 1)
  (compilation-mode -1)
  (read-only-mode -1)
  (while (re-search-forward "\\(\\.\\.\\/\\)+" nil t)
    (replace-match "../../"))
  (set-buffer-modified-p nil)
  (read-only-mode t)
  (compilation-mode t)
  (goto-char 1)
  (compilation-next-error 1)
  nil
  )
(define-key compilation-mode-map (kbd "<f5>") 'my-refresh-compilation-mode)

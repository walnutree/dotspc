(remove-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(remove-hook 'prog-mode-hook 'bug-reference-prog-mode)
(remove-hook 'prog-mode-hook 'auto-highlight-symbol-mode)
;; (remove-hook 'prog-mode-hook 'spacemacs//enable-hs-minor-mode)
(remove-hook 'prog-mode-hook 'goto-address-prog-mode)
(remove-hook 'prog-mode-hook 'smartparens-mode)
;; (set-face-attribute 'sp-show-pair-match-face nil
;;                     :background "steel blue"
;;                     :foreground "white")

(defun spacemacs/prompt-kill-emacs ()
  "Prompt to save changed buffers and hide frame"
  (interactive)
  (save-buffers-kill-terminal))
(global-page-break-lines-mode -1)
(if (boundp 'global-eldoc-mode)
    (global-eldoc-mode -1))

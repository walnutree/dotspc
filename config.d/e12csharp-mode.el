(defun my-csharp-mode-hook ()
  (interactive)
  (my-set-key csharp-mode-map (kbd "M-.") 'omnisharp-go-to-definition))

(eval-after-load 'omnisharp #'my-csharp-mode-hook)

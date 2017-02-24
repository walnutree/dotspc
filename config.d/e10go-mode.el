(defun my-go-mode-hook ()
  (my-set-key go-mode-map (kbd "M-.") 'godef-jump))
(eval-after-load 'go-mode #'my-go-mode-hook)

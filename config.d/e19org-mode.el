(defun my-org-mode-hook()
  (my-set-evil-key evil-org-mode-map (kbd "M-o") nil))

(eval-after-load 'evil-org #'my-org-mode-hook)

(setq org-bullets-bullet-list '("○" "●" "◦" "♠" "♣" "♥" "♦"))

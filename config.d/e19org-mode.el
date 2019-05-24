(defun my-org-mode-hook()
  (my-set-evil-key evil-org-mode-map (kbd "M-o") nil))

(eval-after-load 'evil-org #'my-org-mode-hook)

(setq org-bullets-bullet-list '("○" "●" "◦" "♠" "♣" "♥" "♦"))

;; sub/super text must round with {}, to avoid lots of _ usage in org text
;; https://stackoverflow.com/questions/26636562/org-mode-weirdness-with-org-export-with-sub-superscripts
;; http://orgmode.org/manual/Subscripts-and-superscripts.html#Subscripts-and-superscripts
(setq org-use-sub-superscripts '{})
(setq org-export-with-sub-superscripts '{})

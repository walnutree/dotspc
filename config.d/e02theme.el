;; (set-face-foreground 'region "black")
;; (set-face-background 'region "#eeffff")
;(set-face-foreground 'isearch "#ffffff")
;(set-face-background 'isearch "#0000ff")
;; (set-face-background 'hl-line "#484848")
(set-face-background 'evil-search-highlight-persist-highlight-face "#cd853f")

(custom-set-faces
 '(hi-green ((t (:background "#67b11d" :foreground "#293235"))))
 '(hi-yellow ((t (:background "#b1951d" :foreground "#32322c")))))

(global-hl-line-mode -1)

(defun my/unhighlight-all-in-buffer ()
    "Remove all highlights made by `hi-lock' from the current buffer.
The same result can also be be achieved by \\[universal-argument] \\[unhighlight-regexp]."
    (interactive)
    (unhighlight-regexp t))

(my-set-evil-states-key '(normal) (kbd "SPC o h") 'highlight-symbol-at-point)
(my-set-evil-states-key '(normal) (kbd "SPC o u") 'my/unhighlight-all-in-buffer)

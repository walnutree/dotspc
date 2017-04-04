(eval-when-compile (require 'face-remap))
(defvar my-insert-hl-bg "#213026"
  "hl-line background in insert state")
(defvar-local my-insert-hl-remap nil)

(defun my-setup-hl-bg()
  (if (eq (frame-parameter nil 'background-mode) 'dark)
      (setq my-insert-hl-bg "#383838")
    (setq my-insert-hl-bg "#def8c5")))

(defadvice load-theme (after my-frame-bg-change-func last activate)
  (my-setup-hl-bg))

(defun my-evil-enter-insert-state-hook ()
  (setq my-insert-hl-remap
        (face-remap-add-relative 'hl-line :background my-insert-hl-bg)))

(defun my-evil-leave-insert-state-hook ()
  (face-remap-remove-relative my-insert-hl-remap)
  )

(add-hook 'evil-insert-state-entry-hook 'my-evil-enter-insert-state-hook)
(add-hook 'evil-insert-state-exit-hook 'my-evil-leave-insert-state-hook)
(my-setup-hl-bg)

(defun my/unhighlight-all-in-buffer ()
  "Remove all highlights made by `hi-lock' from the current buffer.
The same result can also be be achieved by \\[universal-argument] \\[unhighlight-regexp]."
  (interactive)
  ;; remove line hightlights
  (spacemacs/toggle-line-numbers)
  (remove-overlays (point-min) (point-max))
  (spacemacs/toggle-line-numbers)
  ;; regex hightlights removal
  (unhighlight-regexp t))

(defun find-overlays-specifying (prop pos)
  (let ((overlays (overlays-at pos))
        found)
    (while overlays
      (let ((overlay (car overlays)))
        (if (overlay-get overlay prop)
            (setq found (cons overlay found))))
      (setq overlays (cdr overlays)))
    found))

(defun highlight-or-dehighlight-line ()
  (interactive)
  (if (find-overlays-specifying
       'line-highlight-overlay-marker
       (line-beginning-position))
      (remove-overlays (line-beginning-position) (+ 1 (line-end-position)))
    (let ((overlay-highlight (make-overlay
                              (line-beginning-position)
                              (+ 1 (line-end-position)))))
      (overlay-put overlay-highlight 'face '(:background "lightyellow"))
      (overlay-put overlay-highlight 'line-highlight-overlay-marker t))))

(my-set-evil-states-key '(normal) (kbd "SPC o h") 'highlight-symbol-at-point)
(my-set-evil-states-key '(normal) (kbd "SPC o l") 'highlight-or-dehighlight-line)
(my-set-evil-states-key '(normal) (kbd "SPC o u") 'my/unhighlight-all-in-buffer)

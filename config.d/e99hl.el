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

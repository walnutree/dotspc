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

;; (my-set-evil-states-key '(normal) (kbd "SPC o h") 'highlight-symbol-at-point)
(my-set-evil-states-key '(normal) (kbd "SPC o l") 'highlight-or-dehighlight-line)
(my-set-evil-states-key '(normal) (kbd "SPC o u") 'my/unhighlight-all-in-buffer)

;; symbol overlay package for highlight
(load "../lisp/symbol-overlay/symbol-overlay.el")

(defun my/symbol-overlay-toggle (symbol)
  (unless (minibufferp)
    (let* ((keyword (symbol-overlay-assoc symbol)))
      (if keyword
          (progn
            (symbol-overlay-remove keyword)
            (symbol-overlay-put-temp-in-window))
        (symbol-overlay-put-all symbol)))))

(setq symbol-overlay-map nil)

(defun symbol-overlay-get-symbol (&optional string noerror)
    "Get the symbol at point.
If STRING is non-nil, `regexp-quote' STRING rather than the symbol.
If NOERROR is non-nil, just return nil when no symbol is found."
    (let ((symbol (or string (thing-at-point 'symbol))))
      (if symbol (regexp-quote symbol)
        (unless noerror (user-error "No symbol at point")))))

(defun my/symbol-overlay-put-dwim ()
  "Toggle all overlays of symbol at point."
  (interactive)
  (if (not mark-active)
      (symbol-overlay-put)
    (my/symbol-overlay-toggle
     (symbol-overlay-get-symbol (filter-buffer-substring (mark) (point)) nil))
    (if (functionp 'evil-force-normal-state)
        (evil-force-normal-state)
      (deactivate-mark))))

(defun my/symbol-overlay-put-on-overlay()
  (interactive)
  (if mark-active
      (my/symbol-overlay-put-dwim)
    (let ((overlays (find-overlays-specifying 'symbol (point))))
      (if overlays
          (let ((keyword (symbol-overlay-assoc
                          (overlay-get (car overlays) 'symbol))))
            (symbol-overlay-remove keyword))))))

(setq symbol-overlay-map
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "SPC o h") 'my/symbol-overlay-put-on-overlay)
        map))

(my-set-evil-states-key '(normal) (kbd "SPC o h") 'my/symbol-overlay-put-dwim)

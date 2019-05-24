(eval-when-compile (require 'magit))
;;(require 'magit)

(defun magit-toggle-file-section ()
  "Like `magit-section-toggle' but toggle at file granularity."
  (interactive)
  (when (eq (magit-section-type (magit-current-section)) 'hunk)
    (magit-section-up))
  (magit-section-toggle (magit-current-section)))

(defun my-magit-mode-hook ()
  (define-key magit-mode-map "h" 'magit-toggle-file-section)
  )
(add-hook 'magit-mode-hook 'my-magit-mode-hook)
(setq-default git-commit-mode-hook '(turn-on-auto-fill))
(global-set-key (kbd "M-r") 'magit-status)

(spacemacs|define-transient-state smerge
  :title "Smerge Transient State"

    :doc "
 Movement^^^^               Merge Action^^           Other
 ---------------------^^^^  -------------------^^    -----------
 [_n_/_p_]  next/prev hunk  [_b_] keep base          [_u_] undo
 [_j_/_k_]  move up/down    [_m_] keep mine          [_R_] refine
 ^^^^                       [_a_] keep all           [_q_] quit
 ^^^^                       [_o_] keep other
 ^^^^                       [_c_] keep current
 ^^^^                       [_C_] combine with next"
    :bindings
    ("n" smerge-next)
    ("p" smerge-prev)
    ("k" smerge-prev)
    ("j" evil-next-line)
    ("k" evil-previous-line)
    ("a" smerge-keep-all)
    ("b" smerge-keep-base)
    ("m" smerge-keep-mine)
    ("o" smerge-keep-other)
    ("c" smerge-keep-current)
    ("C" smerge-combine-with-next)
    ("R" smerge-refine)
    ("u" undo-tree-undo)
    ("q" nil :exit t)
    )

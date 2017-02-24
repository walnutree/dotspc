(xterm-mouse-mode -1)

(setq current-language-environment "UTF-8")
(if (eq window-system 'w32)
    (setq file-name-coding-system 'chinese-gb18030))
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(setq x-select-enable-primary t)
(setq create-lockfiles nil)
(setq-default buffer-file-coding-system 'prefer-utf-8-unix)
(global-set-key (kbd "M-]") 'my-match-paren)
(defun my-match-paren (arg)
  (interactive "p")
  (cond ((looking-at "\\s\(") (progn (forward-list 1) (backward-char)))
        ((looking-at "\\s\)") (progn (forward-char) (backward-list 1)))
        ((looking-back "\\s\)" 1) (backward-list 1))
        )
  )

;no vc handle
(setq vc-handled-backends (quote ()))
(show-paren-mode t)
(set-face-background 'show-paren-match-face "steel blue")
(set-face-foreground 'show-paren-match-face "white")

(setq-default tab-width 8
              tab-always-indent nil)
(setq scroll-margin 4
      scroll-step 1
      scroll-conservatively 10000
      scroll-error-top-bottom t)
(setq bidi-display-reordering nil)
(unless (display-graphic-p)
  (setq nlinum-format "%d ")
  (setq linum-format "%d "))

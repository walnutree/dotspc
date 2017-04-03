(defun myssh (args)
  "Connect to a remote host by SSH."
  (interactive "sssh ")
  (let ((switches (split-string-and-unquote args)))
    (defvar term-term-name "xterm")
    (set-buffer (apply 'make-term "ssh" "ssh" nil switches))
    (term-mode)
    (term-char-mode)
    (switch-to-buffer "*ssh*")))

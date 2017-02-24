(defcustom osc52-max-sequence 100000
   "Maximum length of the OSC 52 sequence.")

(defun osc52-make-escape (string)
  (let ((esc)
        (tmux (getenv "TMUX" (selected-frame))))
    (setq esc
          (concat "\e]52;c;"
                  (base64-encode-string
                   (encode-coding-string
                    string
                    buffer-file-coding-system) t)
                  "\07"))
    (if tmux
        (concat "\ePtmux;\e" esc "\e\\")
      esc)))

(defun osc52-select-text (string)
  (let ((b64-length (+ (* (length string) 3) 2)))
    (if (<= b64-length osc52-max-sequence)
        (send-string-to-terminal (osc52-make-escape string))
      (message "Selection too long to send to terminal %d" b64-length)
      (sit-for 2))))


(defun my-cut-function (text)
  (if (display-graphic-p)
      (x-select-text text)
      (osc52-select-text text)))

(setq interprogram-cut-function #'my-cut-function)

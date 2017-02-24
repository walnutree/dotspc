(defun my-window-system-setup (frame)
  (select-frame frame)
  (if (eq window-system 'w32)
      (progn
        (set-fontset-font "fontset-default" 'unicode
                          (font-spec :size 13.0 :name "ms gothic"))
        (set-fontset-font t 'han
                          (font-spec :family "Microsoft Yahei" :size 12.0)))
    (progn
      (modify-frame-parameters nil '((fullscreen . maximized)))
      (set-fontset-font t 'han
                        (font-spec :family
                                   "Vera Sans YuanTi Mono" :size 12.0))))
  (set-cursor-color "plum3")
  (modify-frame-parameters frame (list (cons 'line-spacing 3)))
  (blink-cursor-mode -1))

(defun my-setup-frame (frame)
  (if (display-graphic-p frame)
      (my-window-system-setup frame)))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'my-setup-frame t)
  (my-setup-frame (selected-frame)))

(defun my-maximize-frame ()
  (modify-frame-parameters nil '((fullscreen . maximized))))
(add-hook 'window-setup-hook #'my-maximize-frame)

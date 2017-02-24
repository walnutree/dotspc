(defun my-set-evil-state-key  (state map key func)
  (if map
      (evil-define-key state map key func)
    (evil-global-set-key state key func)))

(defun my-set-evil-states-key-map (states map key func)
  (mapc (lambda (state)
          (my-set-evil-state-key state map key func))
        states))

(defun my-set-evil-states-key (states key func)
  (my-set-evil-states-key-map states nil key func))

(defun my-set-evil-key(map key func)
  (my-set-evil-states-key-map '(normal insert visual) map key func))

(defun my-undef-evil-key (key)
  (define-key evil-normal-state-map key nil)
  (define-key evil-insert-state-map key nil)
  (define-key evil-visual-state-map key nil)
  (define-key evil-motion-state-map key nil))

(defun my-set-key (map key func)
  (if (and (boundp 'evil-mode) evil-mode)
      (my-set-evil-key map key func)
    (if map
        (define-key map key func)
      (global-set-key key func))))

(setq evil-move-cursor-back nil)
(setq-default evil-escape-delay 0.2)
(setq-default evil-escape-key-sequence "kj")
(spacemacs/set-leader-keys "kj" nil)

(defalias #'forward-evil-word #'forward-evil-symbol)
(setq evil-insert-state-cursor '("red" (bar . 3)))

(global-visual-line-mode t)
(my-set-evil-states-key '(normal motion) (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(my-set-evil-states-key '(normal motion) (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(my-set-evil-states-key '(normal visual motion) (kbd "f") 'scroll-up-command)
(my-set-evil-states-key '(normal visual motion) (kbd "s") 'scroll-down-command)
(my-set-evil-states-key '(normal visual motion) (kbd "H") 'evil-beginning-of-visual-line)
(my-set-evil-states-key '(normal visual motion) (kbd "L") 'evil-end-of-visual-line)
(my-set-evil-states-key '(normal visual motion) (kbd "-") 'evil-end-of-visual-line)
(my-set-evil-states-key '(normal) (kbd ".") (kbd "M-."))
(my-set-evil-states-key '(normal) (kbd ",") (kbd "M-,"))
(my-set-evil-states-key '(normal) (kbd "'") (kbd "M-'"))
;; fix 's' key in visual mode
(evil-define-key 'visual evil-surround-mode-map "s" 'scroll-down-command)
; Make horizontal movement cross lines
(setq-default evil-cross-lines t)

(defun evil-escape--escape-normal-state ()
  "Return the function to escape from normal state."
  (cond
   ((and (fboundp 'helm-alive-p) (helm-alive-p)) 'helm-keyboard-quit)
   ((eq 'ibuffer-mode major-mode) 'ibuffer-quit)
   ((eq 'image-mode major-mode) 'quit-window)
   ((and (fboundp 'evil-escape--is-magit-buffer)
         (evil-escape--is-magit-buffer)) 'evil-escape--escape-with-q)
   ((bound-and-true-p isearch-mode) 'isearch-cancel)
   ((window-minibuffer-p) (kbd "C-g"))
   (t (lookup-key evil-normal-state-map [escape]))))

;; (setq evil-normal-state-tag   (propertize "[N]" 'face '((:background "DarkGoldenrod2")))
;;       evil-emacs-state-tag    (propertize "[E]" 'face '((:background "SkyBlue2")))
;;       evil-insert-state-tag   (propertize "[I]" 'face '((:background "chartreuse3")))
;;       evil-replace-state-tag  (propertize "[R]" 'face '((:background "chocolate" :foreground "white")))
;;       evil-motion-state-tag   (propertize "[M]" 'face '((:background "plum3" :foreground "white")))
;;       evil-visual-state-tag   (propertize "[V]" 'face '((:background "gray")))
;;       evil-operator-state-tag (propertize "[O]" 'face '((:background "purple" :foreground "white"))))

;; (define-key evil-visual-state-map (kbd "s") 'scroll-down-command)
;; (define-key evil-operator-state-map (kbd "s") 'scroll-down-command)
;; (define-key evil-motion-state-map (kbd "s") 'scroll-down-command)
;; (define-key evil-evilified-state-map (kbd "s") 'scroll-down-command)
;; (define-key evil-surround-mode-map (kbd "s") 'scroll-down-command)
;; (evil-define-key 'visual evil-surround-mode-map "s" 'scroll-down-command)

(defun my-set-term-cursor-color (color)
  (let ((color-seq (apply 'color-rgb-to-hex (color-name-to-rgb color))))
    (if color-seq
        (send-string-to-terminal
         (concat "\e]12;" color-seq "\a")))))

(defun my-set-cursor (spec)
  (if (display-graphic-p)
      (setq cursor-type spec)
    (unless (equal cursor-type spec)
      (let ((shape (or (car-safe spec) spec))
            (param))
        (setq param
              (cond ((eq shape 'bar) "6")
                    ((eq shape 'hbar) "4")
                    (t "2")))
        (send-string-to-terminal
         (concat "\e[" param " q"))))))

(defun evil-set-cursor-color (color)
  (unless (equal (frame-parameter nil 'cursor-color) color)
    (set-cursor-color color)
    (unless (display-graphic-p)
      (my-set-term-cursor-color color))))

(defun evil-set-cursor (specs)
  (unless (and (listp specs)
               (null (cdr-safe (last specs))))
    (setq specs (list specs)))
  (dolist (spec specs)
    (cond
     ((functionp spec)
      (condition-case nil
          (funcall spec)
        (error nil)))
     ((stringp spec)
      (evil-set-cursor-color spec))
     (t
      (my-set-cursor spec)))))

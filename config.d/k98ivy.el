(require 'ivy)

(defun map-key (c)
  `(lambda () (interactive) (insert-char ,c)))

(defvar ivy-jk-map-is-hook nil)

(defun ivy-setup-jk-map()
  (interactive)
  (let ((map ivy-minibuffer-map))
    (unless ivy-jk-map-is-hook
      (setq ivy-jk-map-is-hook t)
      (define-key map (kbd "SPC") 'ivy-toggle-jk-map)
      (define-key map (kbd "j") 'ivy-next-line)
      (define-key map (kbd "k") 'ivy-previous-line))))

(defun ivy-remove-jk-map ()
  (let ((map ivy-minibuffer-map))
    (if ivy-jk-map-is-hook
        (progn
          (setq ivy-jk-map-is-hook nil)
          (define-key map (kbd "SPC") 'self-insert-command)
          (define-key map (kbd "j") 'self-insert-command)
          (define-key map (kbd "k") 'self-insert-command)))))


(defun ivy-toggle-jk-map ()
  (interactive)
  (if (not ivy-jk-map-is-hook)
      (ivy-setup-jk-map)
    (ivy-remove-jk-map)))


(setq ivy--regex-function 'ivy--regex-fuzzy)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
(define-key ivy-minibuffer-map (kbd "M-n") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "M-p") 'ivy-previous-line)
(define-key ivy-minibuffer-map (kbd "M-m") 'ivy-toggle-jk-map)
(set-face-background 'ivy-current-match "#c7edcc")

(defun ivy-read-ad (orig-func &rest args)
  (ivy-setup-jk-map)
  (apply orig-func args))

(advice-add 'ivy-read :around #'ivy-read-ad)

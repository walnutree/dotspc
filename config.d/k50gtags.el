(require 'gtags)
(autoload 'gtags-mode "gtags" "" t)
(require 'hl-line)

;; 16 is too small for code browse.
(let ((len 1024))
  (if (boundp 'xref--marker-ring)
      (progn
        (setq xref-marker-ring-length len)
        (setq xref--marker-ring (make-ring xref-marker-ring-length)))
    (setq find-tag-marker-ring-length len)
    (setq find-tag-marker-ring (make-ring find-tag-marker-ring-length))))

(defun my-gtags-visit-rootdir ()
  (interactive)
  (let ((dir  (gtags-visit-rootdir)))
    (if dir
        (let ((len (1- (length gtags-rootdir))))
          (while (eq (aref gtags-rootdir len) ?/)
            (setq gtags-rootdir (substring gtags-rootdir 0 len))
            (setq len (1- len))))
      (setq gtags-rootdir nil)))
  (setenv "GTAGSROOT" gtags-rootdir))

(defun my-gtags-clear-rootdir ()
   (interactive)
   (message "clear gtags root directory")
   (setq gtags-rootdir nil)
   (setenv "GTAGSROOT" nil))

(defvar global-force-visual-line-mode-off nil
  "Force visual-line-mode off")

(defun turn-on-visual-line-mode ()
  (if (not global-force-visual-line-mode-off)
      (visual-line-mode 1)))

(defun my-gtags-select-mode-hook ()
  (local-set-key (kbd "RET") 'gtags-select-tag)
  (setq visual-line-mode nil)
  (setq global-force-visual-line-mode-off t)
  (hl-line-mode))

(add-hook 'gtags-select-mode-hook 'my-gtags-select-mode-hook)
(add-hook 'c-mode-common-hook
          (lambda()
            (gtags-mode 1)))

(setq gtags-auto-update t)

;; fixup slow ivy read
(defun my-gtags-completing-read (prompt collection &optional predicate
                                        require-match initial-input
                                        hist def inherit-input-method)
  (let ((completion-in-region-function 'completion--in-region))
    (completing-read-default prompt collection predicate
                             require-match initial-input
                             hist def inherit-input-method)))
(setq gtags-completing-read-function 'my-gtags-completing-read)

;;;; key definitions
(defun my-define-gtags-key (key func)
  (global-set-key key func)
  (define-key gtags-mode-map key func)
  (define-key gtags-select-mode-map key func))

(global-set-key (kbd "C-c d") 'my-gtags-visit-rootdir)
(global-set-key (kbd "C-c c") 'my-gtags-clear-rootdir)

(my-define-gtags-key (kbd "M-.") 'gtags-find-tag)
(my-define-gtags-key (kbd "M-,") 'pop-tag-mark)
(my-define-gtags-key (kbd "M-'") 'gtags-find-rtag)
(my-set-key gtags-select-mode-map (kbd "RET") 'gtags-select-tag)

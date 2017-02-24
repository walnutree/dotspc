(require 'bookmark+)

(defun bmkp-cycle (increment &optional other-window startoverp)
  (interactive (let ((startovr  (consp current-prefix-arg)))
                 (list (if startovr 1 (prefix-numeric-value current-prefix-arg)) nil startovr)))
  (bookmark-maybe-load-default-file)
  (setq bmkp-nav-alist bookmark-alist)
  (unless (and bmkp-current-nav-bookmark  (not startoverp)
               (bookmark-get-bookmark bmkp-current-nav-bookmark 'NOERROR))
    (setq bmkp-current-nav-bookmark  (car bmkp-nav-alist)))
  (bmkp-cycle-1 increment other-window startoverp))

(defun bookmark-save (&optional parg file) ; Bound to `C-x p s'
  (interactive "P")
  (bookmark-maybe-load-default-file)
  (let ((file-to-save
         (cond ((and (not parg)  (not file))  bmkp-current-bookmark-file)
               ((and (not parg)  file)        file)
               ((and parg  (not file))        (bmkp-read-bookmark-file-name
                                               "File to save bookmarks in: ")))))
    (bookmark-write-file file-to-save))
  (setq bookmark-alist-modification-count  0
        bmkp-modified-bookmarks            ())
  (bmkp-refresh/rebuild-menu-list))     ; $$$$$$ Should this be done only when interactive?

;; don't save bookmark when jump
(defun bmkp-update-autonamed-bookmark (bookmark)
  (bookmark-get-bookmark bookmark))

;; My auto name.
(defun bmkp-my-autoname-bookmark-function (position)
  (let ((line (line-number-at-pos position)))
    (format "#%05d %s" (abs line) (buffer-name))))

(setq bmkp-autoname-format "^\#[0-9]\\{5\\} %s")

(setq bmkp-autoname-bookmark-function 'bmkp-my-autoname-bookmark-function)

;; don't modify init.el
(setq bmkp-last-as-first-bookmark-file nil)

(setq bookmark-save-flag 4)
(setq bmkp-auto-light-when-set 'any-bookmark)
(setq bmkp-auto-light-when-jump 'any-bookmark)
(setq bmkp-light-left-fringe-bitmap 'right-triangle)
(setq bmkp-light-style-autonamed 'lfringe)
(setq bmkp-light-style-non-autonamed 'lfringe)

(defun my-bookmark-bmenu-mode-hook ()
  (local-unset-key (kbd "M-o"))
  (local-unset-key (kbd "C-o"))
  (local-set-key (kbd "j") 'next-line)
  (local-set-key (kbd "k") 'previous-line)
  (local-set-key (kbd "v") 'bookmark-bmenu-switch-other-window))

(add-hook 'bookmark-bmenu-mode-hook 'my-bookmark-bmenu-mode-hook)

(global-set-key (kbd "C-x m") 'bmkp-toggle-autonamed-bookmark-set/delete)
(my-set-evil-states-key '(normal motion visual) (kbd "z ;") 'bmkp-toggle-autonamed-bookmark-set/delete)
(my-set-evil-states-key '(normal motion visual) (kbd "z j") 'bmkp-next-bookmark)
(my-set-evil-states-key '(normal motion visual) (kbd "z k") 'bmkp-next-bookmark)
(global-set-key (kbd "<f8>")   'bookmark-bmenu-list)
(global-set-key (kbd "<f9>")   'bmkp-next-bookmark)
(global-set-key (kbd "<f10>") 'bmkp-previous-bookmark)

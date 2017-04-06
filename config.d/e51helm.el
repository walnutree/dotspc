(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(custom-set-variables
 '(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t))

;; key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "C-c x") 'helm-gtags-select)
     (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

(custom-set-variables
 '(helm-gtags-suggested-key-mapping t))
;; (setq helm-fuzzy-sort-fn nil)

(my-set-evil-states-key '(normal) (kbd "SPC o s") 'helm-gtags-select)
(my-set-evil-states-key '(normal) (kbd "SPC o f") 'helm-find)
(my-set-evil-states-key '(normal) (kbd "SPC o i") 'helm-gid)

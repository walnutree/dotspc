;; force stop prerunning server
(if (eq window-system 'w32)
    (progn
      (require 'server)
      (server-force-delete)))

;; for fuzzy find in helmo-gtags
(custom-set-variables
 ;;   '(helm-gtags-fuzzy-match t)
 '(helm-gtags-maximum-candidates 500))
(setq configuration-layer--elpa-archives
      '(("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
        ("org-cn"   . "http://elpa.emacs-china.org/org/")
        ("gnu-cn"   . "http://elpa.emacs-china.org/gnu/")))
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
          ("melpa" . "http://elpa.emacs-china.org/melpa/")))
 

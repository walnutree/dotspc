(eval-when-compile (require 'anaconda-mode))
(defun my-anaconda-mode-hook()
  (define-key anaconda-mode-map (kbd "M-,") 'anaconda-mode-go-back)
  (define-key anaconda-mode-map (kbd "M-n") 'anaconda-mode-find-references)
  (define-key anaconda-mode-map (kbd "M-'") 'anaconda-mode-find-assignments))
(add-hook 'anaconda-mode-hook 'my-anaconda-mode-hook)

(evilified-state-evilify anaconda-mode-view-mode anaconda-mode-view-mode-map
  (kbd "j") 'next-error-no-select
  (kbd "k") 'previous-error-no-select
  (kbd "n") 'next-error-no-select
  (kbd "p") 'previous-error-no-select
  (kbd "q") 'quit-window)

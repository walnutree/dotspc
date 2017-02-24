(add-hook 'eshell-mode-hook
          '(lambda ()
             (if (boundp 'company-mode)
                 (company-mode -1))))

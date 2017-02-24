;; show function name in headline
(which-function-mode)

(setq mode-line-misc-info (delete (assoc 'which-func-mode
                                         mode-line-misc-info) mode-line-misc-info)
      which-func-header-line-format '(which-func-mode ("" which-func-format)))
(defadvice which-func-ff-hook (after header-line activate)
  (when which-func-mode
    (setq mode-line-misc-info (delete (assoc 'which-func-mode
                                             mode-line-misc-info) mode-line-misc-info)
          header-line-format which-func-header-line-format)))

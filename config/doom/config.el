;;; -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "PragmataPro" :size 18))

(after! evil-escape
  (evil-escape-mode 1)
  (setq-default evil-escape-key-sequence "fd"))

(after! magit
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-unpushed-to-upstream
                          'magit-insert-unpushed-to-upstream-or-recent
                          'replace))

(defun private/ruby-mode-hook ()
  (setq ruby-insert-encoding-magic-comment nil
        tab-width 2))

(add-hook! ruby-mode #'private/ruby-mode-hook)

(defun private/yaml-mode-hook ()
  (setq tab-width 2))

(add-hook! yaml-mode #'private/yaml-mode-hook)

(defun private/latex-mode-hook ()
  (auto-fill-mode 1))

(add-hook! latex-mode #'private/latex-mode-hook)

(defun private/c++-mode-hook ()
  (c-set-offset 'innamespace 0)
  (c-set-offset 'access-label '-)
  (c-set-offset 'inclass '+))


(add-hook! c++-mode #'private/c++-mode-hook)

(defun private/company-mode-hook ()
  (let ((map company-active-map))
    (define-key map (kbd "RET") 'nil)
    (define-key map (kbd "TAB") 'nil)))

(add-hook! company-mode #'private/company-mode-hook)

(map! (:leader
        (:desc "search" :prefix "s"
          :desc "No Highlight" :nv "c" #'evil-ex-nohighlight))
      (:after company
        (:map company-active-map
          "C-SPC" #'company-complete
          [return] 'nil
          [tab] 'nil)))

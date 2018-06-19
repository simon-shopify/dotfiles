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

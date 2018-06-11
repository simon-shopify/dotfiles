;;; -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "PragmataPro" :size 18))

(evil-escape-mode 1)
(setq-default evil-escape-key-sequence "fd")

(add-hook! ruby-mode
  (setq ruby-insert-encoding-magic-comment nil))

(add-hook! latex-mode
  (auto-fill-mode 1))

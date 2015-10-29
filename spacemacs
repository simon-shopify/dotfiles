;; -*- mode: dotspacemacs -*-

(defun dotspacemacs/layers ()
  (setq
   dotspacemacs-configuration-layer-path
   '("~/.spacemacs-layers")
   dotspacemacs-configuration-layers
   `(auto-completion
     c-c++
     clojure
     (colors :variables colors-enable-nyan-cat-progress-bar ,(display-graphic-p))
     elixir
     emacs-lisp
     git
     javascript
     lua
     haskell
     html
     idris
     markdown
     python
     restclient
     ruby
     rust
     shell
     syntax-checking
     vagrant
     version-control
     yaml)

   dotspacemacs-excluded-packages
   '(company-quickhelp
     rainbow-delimiters
     yasnippet
     ruby-tools)))

;; Settings
;; --------

(setq-default
 dotspacemacs-editing-style 'vim
 dotspacemacs-themes '(solarized-light)
 dotspacemacs-leader-key "SPC"
 dotspacemacs-major-mode-leader-key ","
 dotspacemacs-command-key ":"
 dotspacemacs-guide-key-delay 0.4
 dotspacemacs-colorize-cursor-according-to-state t

 dotspacemacs-default-font '("PragmataPro"
                             :size 13
                             :weight normal
                             :width normal
                             :powerline-scale 1.1)

 dotspacemacs-active-transparency 100
 dotspacemacs-inactive-transparency 100
 dotspacemacs-mode-line-unicode-symbols t
 dotspacemacs-smooth-scrolling t
 dotspacemacs-feature-toggle-leader-on-jk nil
 dotspacemacs-smartparens-strict-mode nil
 dotspacemacs-persistent-server nil)

;; Initialization Hooks
;; --------------------

(defun sgnr/term-send-meta-backspace ()
  (interactive)
  (term-send-raw-string "\C-w"))

(defun dotspacemacs/init ()
  (menu-bar-mode -1)
  (setq-default require-final-newline t)
  (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.mrb$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
  (setq auto-completion-return-key-behavior nil
        auto-completion-tab-key-behavior 'complete
        enh-ruby-add-encoding-comment-on-save nil))

(defun dotspacemacs/user-config ()
  (setq powerline-default-separator 'bar
        sgml-basic-offset 2
        web-mode-markup-indent-offset 2
        projectile-enable-caching nil
        enable-remote-dir-locals t
        js2-mode-show-strict-warnings nil
        undo-limit 200000)
  (global-hl-line-mode 0)
  (recentf-mode 0)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (sp-pair "'" nil :actions :rem)
  (sp-pair "\"" nil :actions :rem)

  (evil-leader/set-key "js" 'evil-surround-change)

  (add-hook
   'term-mode-hook
   '(lambda ()
      (define-key term-raw-map (kbd "M-<backspace>") 'sgnr/term-send-meta-backspace)
      (define-key term-raw-map (kbd "M-x") 'helm-M-x)
      (define-key term-raw-map (kbd "M-:") 'eval-expression)))

  (add-hook
   'c-mode-hook
   '(lambda ()
      (setq c-basic-offset 2)
      (c-toggle-auto-newline 0)
      (c-set-offset 'arglist-intro 2)
      (c-set-offset 'arglist-close 0)
      (c-set-offset 'inextern-lang 0)))

  (remove-hook 'enh-ruby-mode-hook 'ruby-end-mode)
  (add-hook
   'enh-ruby-mode-hook
   '(lambda ()
      (modify-syntax-entry ?_ "w")
      (setq enh-ruby-deep-indent-paren nil
            flycheck-rubocoprc "~/.rubocop.yml"
            evil-shift-width 2)))

  (add-hook
   'yaml-mode-hook
   '(lambda ()
      (modify-syntax-entry ?_ "w")))

  (add-hook
   'web-mode-hook
   '(lambda ()
      (setq web-mode-code-indent-offset 2)))

  (add-hook
   'js2-mode-hook
   '(lambda ()
      (setq js2-basic-offset 2)))

  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (setq haskell-process-type 'stack-ghci)
  (setq flycheck-disabled-checkers '(haskell-ghc))

  (add-hook
   'markdown-mode-hook
   '(lambda ()
      (sp-pair "`" nil :actions :rem))))

;; Custom variables
;; ----------------

;; Do not write anything in this section. This is where Emacs will
;; auto-generate custom variable definitions.

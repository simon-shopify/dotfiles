;; -*- mode: dotspacemacs -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-configuration-layer-path '("~/.spacemacs-layers/")

   dotspacemacs-configuration-layers
   '(auto-completion
     c-c++
     clojure
     '(company-mode :variables auto-completion-use-tab-instead-of-enter t)
     emacs-lisp
     git
     javascript
     lua
     haskell
     html
     idr
     markdown
     python
     ruby
     rust
     shell
     syntax-checking
     vagrant
     version-control)

   dotspacemacs-excluded-packages
   '(company-quickhelp
     rainbow-delimiters
     yasnippet
     ruby-tools)))

;; Settings
;; --------

(setq-default
 dotspacemacs-themes '(solarized-light)
 dotspacemacs-leader-key "SPC"
 dotspacemacs-major-mode-leader-key ","
 dotspacemacs-command-key ":"
 dotspacemacs-guide-key-delay 0.4
 dotspacemacs-colorize-cursor-according-to-state t

 dotspacemacs-default-font '("Fira Mono"
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

(defun dotspacemacs/init ()
  (menu-bar-mode -1)
  (setq-default require-final-newline t)
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.mrb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
  (setq auto-completion-return-key-behavior nil
        auto-completion-tab-key-behavior 'complete))

(defun dotspacemacs/config ()
  (setq powerline-default-separator 'bar)
  (setq sgml-basic-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq projectile-enable-caching nil)
  (setq enable-remote-dir-locals t)
  (global-hl-line-mode 0)
  (recentf-mode 0)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (sp-pair "'" nil :actions :rem)
  (sp-pair "\"" nil :actions :rem)

  (evil-leader/set-key "js" 'evil-surround-change)

  (add-hook
   'term-mode-hook
   '(lambda ()
      (define-key evil-insert-state-local-map "\C-p" 'term-send-up)
      (define-key evil-insert-state-local-map "\C-n" 'term-send-down)))

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
      (setq enh-ruby-deep-indent-paren nil
            flycheck-rubocoprc "~/.rubocop.yml"
            evil-shift-width 2)))

  (add-hook
   'markdown-mode-hook
   '(lambda ()
      (sp-pair "`" nil :actions :rem))))

;; Custom variables
;; ----------------

;; Do not write anything in this section. This is where Emacs will
;; auto-generate custom variable definitions.

;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '("~/.spacemacs-layers")
   dotspacemacs-configuration-layers
   '((auto-completion :variables
                      auto-completion-return-key-behavior nil
                      auto-completion-tab-key-behavior nil
                      auto-completion-complete-with-key-sequence "jk")
     better-defaults
     emacs-lisp
     git
     helm
     (ruby :variables
           ruby-version-manager 'chruby
           ruby-enable-enh-ruby-mode t)
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     (spell-checking :variables
                     spell-checking-enable-by-default nil)
     (syntax-checking :variables
                      syntax-checking-enable-tooltips nil)
     version-control)
   dotspacemacs-additional-packages '()
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(orgit)
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 5) (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(spacemacs-dark spacemacs-light)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("PragmataPro"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.0)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text t
   dotspacemacs-ex-substitute-global t
   dotspacemacs-default-layout-name "default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 2
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state t
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 100
   dotspacemacs-inactive-transparency 100
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode t
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("rg" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed))

(defun dotspacemacs/user-init ())

(defconst simon-shopify//default-ruby-version "2.3.3")

(defun simon-shopify//file-name-in-project-root (file-name)
  (concat (file-name-as-directory (projectile-project-root)) file-name))

(defun simon-shopify//read-ruby-version ()
  (lexical-let ((ruby-version-file-path (simon-shopify//file-name-in-project-root ".ruby-version")))
    (cond
     ((file-exists-p ruby-version-file-path)
      (with-temp-buffer
        (insert-file-contents (simon-shopify//ruby-version-file-path))
        (buffer-string)))
     (t simon-shopify//default-ruby-version))))

(defun simon-shopify//use-local-rubocop ()
  (lexical-let ((rubocop-path (simon-shopify//file-name-in-project-root "bin/rubocop")))
    (when (file-executable-p rubocop-path)
      (setq flycheck-ruby-rubocop-executable rubocop-path))))

(defun simon-shopify//ruby-mode-hook ()
  (simon-shopify//use-local-rubocop)
  (lexical-let* ((ruby-version (simon-shopify//read-ruby-version))
                 (ruby-version-directory (concat "/opt/rubies/" ruby-version))
                 (ruby-program (concat (file-name-as-directory ruby-version-directory) "bin/ruby")))
    (when (file-executable-p ruby-program)
      (setq enh-ruby-program ruby-program
            flycheck-ruby-executable ruby-program)
      (chruby ruby-version))))

(defun dotspacemacs/user-config ()
  (setq powerline-default-separator nil
        projectile-enable-caching t
        flycheck-check-syntax-automatically '(save mode-enabled))
  (spaceline-compile)

  (chruby simon-shopify//default-ruby-version)
  (add-hook 'enh-ruby-mode-hook 'simon-shopify//ruby-mode-hook)
  (remove-hook 'enh-ruby-mode-hook 'rubocop-mode))

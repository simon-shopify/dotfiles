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
     (c-c++ :variables
            c-c++-enable-clang-support t)
     docker
     elixir
     emacs-lisp
     git
     (go :variables go-tab-width 2)
     helm
     html
     javascript
     latex
     lua
     markdown
     perl
     (ruby :variables
           ruby-version-manager 'chruby
           ruby-enable-enh-ruby-mode t)
     rust
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     (spell-checking :variables
                     spell-checking-enable-by-default nil)
     (syntax-checking :variables
                      syntax-checking-enable-tooltips nil)
     version-control
     yaml)
   dotspacemacs-additional-packages '()
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '()
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
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("rg" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed))

(defun dotspacemacs/user-init ()
  (setq exec-path-from-shell-arguments '("-l")))

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

(defun simon-shopify//enter-chruby ()
  (lexical-let ((ruby-version (simon-shopify//read-ruby-version)))
    (chruby ruby-version)
    ruby-version))

(defun simon-shopify//ruby-mode-hook ()
  (simon-shopify//use-local-rubocop)
  (lexical-let* ((delimiter-face-foreground (face-foreground 'enh-ruby-string-delimiter-face)))
    (set-face-foreground 'enh-ruby-regexp-delimiter-face delimiter-face-foreground)
    (set-face-foreground 'enh-ruby-heredoc-delimiter-face delimiter-face-foreground))
  (lexical-let* ((ruby-version (simon-shopify//enter-chruby))
                 (ruby-version-directory (concat "/opt/rubies/" ruby-version))
                 (ruby-program (concat (file-name-as-directory ruby-version-directory) "bin/ruby")))
    (when (file-executable-p ruby-program)
      (setq enh-ruby-program ruby-program
            flycheck-ruby-executable ruby-program))))

(defun simon-shopify//configure-ruby ()
  (setq enh-ruby-add-encoding-comment-on-save nil)
  (chruby simon-shopify//default-ruby-version)
  (add-hook 'enh-ruby-mode-hook 'simon-shopify//ruby-mode-hook t)
  (remove-hook 'enh-ruby-mode-hook 'rubocop-mode))

(defun simon-shopify//rb-config (key)
  (lexical-let ((command (concat "ruby -e 'print(RbConfig::CONFIG[%(" key ")])'")))
    (shell-command-to-string command)))

(defun simon-shopify//c-mode-hook ()
  (simon-shopify//enter-chruby)
  (lexical-let ((ruby-header-dir (simon-shopify//rb-config "rubyhdrdir")))
    (add-to-list 'flycheck-clang-include-path ruby-header-dir))
  (lexical-let ((ruby-arch-header-dir (simon-shopify//rb-config "rubyarchhdrdir")))
    (add-to-list 'flycheck-clang-include-path ruby-arch-header-dir))
  (c-set-offset 'arglist-intro '+))

(defun simon-shopify//configure-c ()
  (add-hook 'c-mode-hook 'simon-shopify//c-mode-hook t))

(defun simon-shopify//configure-rust ()
  (setq rust-indent-offset 2))

(defun simon-shopify//configure-spaceline ()
  (spaceline-toggle-version-control-off)
  (setq powerline-default-separator nil)
  (spaceline-compile))

(defun simon-shopify//configure-magit ()
  (with-eval-after-load 'magit
    (magit-add-section-hook 'magit-status-sections-hook
                            'magit-insert-unpushed-to-upstream
                            'magit-insert-unpushed-to-upstream-or-recent
                            'replace)))

(defun dotspacemacs/user-config ()
  (setq projectile-enable-caching t
        flycheck-check-syntax-automatically '(save mode-enabled))
  (simon-shopify//configure-rust)
  (simon-shopify//configure-c)
  (simon-shopify//configure-spaceline)
  (simon-shopify//configure-ruby)
  (simon-shopify//configure-magit))

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (web-mode realgud mwim js2-refactor go-tag flx-ido eshell-prompt-extras dumb-jump chruby auto-compile auctex-latexmk smartparens flycheck projectile helm helm-core magit magit-popup git-commit ghub with-editor async markdown-mode org-plus-contrib yasnippet powerline dash yaml-mode xterm-color ws-butler winum which-key web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package unfill toml-mode toc-org test-simple tagedit symon string-inflection spaceline smeargle slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode ruby-refactor rubocop rspec-mode robe restart-emacs rbenv rake rainbow-delimiters racer pug-mode popwin ponylang-mode pony-snippets persp-mode perl6-mode password-generator paradox packed overseer org-bullets open-junk-file ob-elixir neotree nameless multiple-cursors multi-term move-text mmm-mode minitest markdown-toc magit-gitflow macrostep lorem-ipsum loc-changes load-relative livid-mode linum-relative link-hint less-css-mode js-doc info+ indent-guide impatient-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-rtags helm-purpose helm-projectile helm-mode-manager helm-make helm-gtags helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate google-c-style golden-ratio godoctor go-rename go-guru go-eldoc gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md ggtags fuzzy flyspell-correct-helm flycheck-rust flycheck-rtags flycheck-pos-tip flycheck-pony flycheck-mix flycheck-credo fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z esh-help enh-ruby-mode emmet-mode elisp-slime-nav editorconfig dockerfile-mode docker disaster diminish diff-hl define-word company-web company-tern company-statistics company-rtags company-lua company-go company-c-headers company-auctex column-enforce-mode coffee-mode cmake-mode cmake-ide clean-aindent-mode clang-format cargo bundler browse-at-remote auto-yasnippet auto-highlight-symbol auto-dictionary alchemist aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)

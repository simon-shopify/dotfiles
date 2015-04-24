;; -*- mode: dotspacemacs -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-configuration-layer-path '("~/.spacemacs-layers/")

   dotspacemacs-configuration-layers
   '(auto-completion
     c-c++
     clojure
     company-mode
     git
     lua
     haskell
     html
     idr
     markdown
     python
     ruby
     rust
     syntax-checking)

   dotspacemacs-excluded-packages
   '(company-quickhelp
     enh-ruby-mode
     rainbow-delimiters
     yasnippet)))

;; Settings
;; --------

(setq-default
 dotspacemacs-startup-banner 999
 dotspacemacs-themes '(solarized-light)
 dotspacemacs-leader-key "SPC"
 dotspacemacs-major-mode-leader-key ","
 dotspacemacs-command-key ":"
 dotspacemacs-guide-key-delay 0.4

 dotspacemacs-default-font '("Input Mono"
                             :size 14
                             :weight normal
                             :width normal
                             :powerline-scale 1.1)

 ;; If non nil the frame is fullscreen when Emacs starts up (Emacs 24.4+ only).
 dotspacemacs-fullscreen-at-startup nil
 ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
 ;; Use to disable fullscreen animations in OSX."
 dotspacemacs-fullscreen-use-non-native nil
 ;; If non nil the frame is maximized when Emacs starts up (Emacs 24.4+ only).
 ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
 dotspacemacs-maximized-at-startup nil
 ;; A value from the range (0..100), in increasing opacity, which describes the
 ;; transparency level of a frame when it's active or selected. Transparency can
 ;; be toggled through `toggle-transparency'.
 dotspacemacs-active-transparency 90
 ;; A value from the range (0..100), in increasing opacity, which describes the
 ;; transparency level of a frame when it's inactive or deselected. Transparency
 ;; can be toggled through `toggle-transparency'.
 dotspacemacs-inactive-transparency 90
 ;; If non nil unicode symbols are displayed in the mode line (e.g. for lighters)
 dotspacemacs-mode-line-unicode-symbols nil
 ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth scrolling
 ;; overrides the default behavior of Emacs which recenters the point when
 ;; it reaches the top or bottom of the screen
 dotspacemacs-smooth-scrolling t
 ;; If non nil pressing 'jk' in insert state, ido or helm will activate the
 ;; evil leader.
 dotspacemacs-feature-toggle-leader-on-jk nil
 ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
 dotspacemacs-smartparens-strict-mode nil
 ;; If non nil advises quit functions to keep server open when quitting.
 dotspacemacs-persistent-server nil
 ;; The default package repository used if no explicit repository has been
 ;; specified with an installed package.
 ;; Not used for now.
 dotspacemacs-default-package-repository nil
 )

;; Initialization Hooks
;; --------------------

(defun dotspacemacs/init ()
  (menu-bar-mode -1)
  (setq-default require-final-newline t)
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.mrb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
  (setq-default company-mode-use-tab-instead-of-enter t))

(defun dotspacemacs/config ()
  (setq powerline-default-separator nil)
  (setq c-basic-offset 2)
  (setq sgml-basic-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq projectile-enable-caching nil)
  (global-hl-line-mode 0)
  (recentf-mode 0)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  ;; C
  (add-hook
   'c-mode-hook
   '(lambda ()
      (c-toggle-auto-newline 0)
      (c-set-offset 'arglist-intro 2)
      (c-set-offset 'arglist-close 0)
      (c-set-offset 'inextern-lang 0)))

  ;; Ruby
  (add-hook
   'ruby-mode-hook
   '(lambda ()
      (flycheck-mode 1)
      (setq evil-shift-width ruby-indent-level
            ruby-deep-indent-paren nil
            ruby-deep-arglist nil)))

  ;; Markdown
  (add-hook
   'markdown-mode-hook
   '(lambda ()
      (sp-pair "`" nil :actions :rem))))

;; Custom variables
;; ----------------

;; Do not write anything in this section. This is where Emacs will
;; auto-generate custom variable definitions.

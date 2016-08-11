;; -*- mode: dotspacemacs -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '("~/.spacemacs-layers")
   dotspacemacs-configuration-layers `(auto-completion
                                       c-c++
                                       clojure
                                       colors
                                       elm
                                       emacs-lisp
                                       git
                                       javascript
                                       lua
                                       haskell
                                       html
                                       idris
                                       markdown
                                       purescript
                                       react
                                       (ruby :variables
                                             ruby-version-manager 'chruby
                                             ruby-enable-enh-ruby-mode t)
                                       rust
                                       shell
                                       (syntax-checking :variables
                                                        syntax-checking-enable-tooltips nil)
                                       version-control
                                       yaml)
   dotspacemacs-additional-packages '()
   dotspacemacs-excluded-packages '()
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  (setq-default dotspacemacs-elpa-https t
                dotspacemacs-editing-style 'vim
                dotspacemacs-themes '(solarized-light solarized-dark)
                dotspacemacs-leader-key "SPC"
                dotspacemacs-major-mode-leader-key ","
                dotspacemacs-command-key ":"
                dotspacemacs-guide-key-delay 0.4
                dotspacemacs-colorize-cursor-according-to-state t
                dotspacemacs-active-transparency 100
                dotspacemacs-inactive-transparency 100
                dotspacemacs-mode-line-unicode-symbols t
                dotspacemacs-smooth-scrolling t
                dotspacemacs-feature-toggle-leader-on-jk nil
                dotspacemacs-smartparens-strict-mode t
                dotspacemacs-persistent-server nil
                dotspacemacs-highlight-delimiters nil
                dotspacemacs-default-font '("PragmataPro"
                                            :size 17
                                            :weight normal
                                            :width normal)))

(defun sgnr/term-send-meta-backspace ()
  (interactive)
  (term-send-raw-string "\C-w"))

(defun sgnr/use-local-eslint ()
  (lexical-let* ((project-root (projectile-project-root))
                 (eslint-path (concat (file-name-as-directory project-root) "node_modules/.bin/eslint")))
    (when (file-executable-p eslint-path)
      (setq flycheck-javascript-eslint-executable eslint-path))))

(defun sgnr/symbol-with-hash-rocket-region ()
  (list
   (save-excursion
     (if (looking-at-p ":")
         (point)
       (search-backward ":" (line-beginning-position) t)))
   (save-excursion
     (when (and (looking-at-p ":") (not (eolp)))
       (forward-char))
     (if (re-search-forward "=>" (line-end-position) t)
         (1+ (point))
       (line-end-position)))))

(defun sgnr/ruby-to-new-style-hash ()
  (interactive)
  (when (and (not (ruby-tools-string-at-point-p)) (ruby-tools-symbol-at-point-p))
    (let* ((region (sgnr/symbol-with-hash-rocket-region))
           (min (nth 0 region))
           (max (nth 1 region))
           (content
            (buffer-substring-no-properties min max)))
      (setq content
            (replace-regexp-in-string ":\\([a-zA-Z_][a-zA-Z_0-9]*\\)\s*=>" "\\1:" content))
      (let ((orig-point (point)))
        (delete-region min max)
        (insert content)
        (goto-char orig-point)))))

(defconst sgnr/pragmatapro-font-lock-symbols-alist
  (mapcar (lambda (s)
            (cons (car s) (decode-char 'ucs (cdr s))))
          '(("!!" . #XE720)
            ("!=" . #XE721)
            ("!==" . #XE722)
            ("!!!" . #XE723)
            ;; ("!===" . #XE724)
            ;; ("!===" . #XE725)
            ("!>" . #XE726)
            ("#(" . #XE740)
            ("#_" . #XE741)
            ("#{" . #XE742)
            ("#?" . #XE743)
            ("#>" . #XE744)
            ("%=" . #XE750)
            ("%>" . #XE751)
            ("<~" . #XE75F)
            ("&%" . #XE760)
            ("&&" . #XE761)
            ("&*" . #XE762)
            ("&+" . #XE763)
            ("&-" . #XE764)
            ("&/" . #XE765)
            ("&=" . #XE766)
            ("&&&" . #XE767)
            ("&>" . #XE768)
            ("$>" . #XE775)
            ("~>" . #XE77F)
            ("***" . #XE780)
            ("*=" . #XE781)
            ("*/" . #XE782)
            ("*>" . #XE783)
            ("++" . #XE790)
            ("+++" . #XE791)
            ("+=" . #XE792)
            ("+>" . #XE793)
            ("--" . #XE7A0)
            ("-<" . #XE7A1)
            ("-<<" . #XE7A2)
            ("-=" . #XE7A3)
            ("->" . #XE7A4)
            ("->>" . #XE7A5)
            ("---" . #XE7A6)
            ("-->" . #XE7A7)
            (".." . #XE7B0)
            ("..." . #XE7B1)
            ("..<" . #XE7B2)
            (".>" . #XE7B3)
            (".~" . #XE7B4)
            (".=" . #XE7B5)
            ("/*" . #XE7C0)
            ("//" . #XE7C1)
            ("/>" . #XE7C2)
            ("/=" . #XE7C3)
            ("/==" . #XE7C4)
            ("///" . #XE7C5)
            ("/**" . #XE7C6)
            ("::" . #XE7D0)
            (":=" . #XE7D1)
            (":=>" . #XE7D4)
            ("<$>" . #XE7E0)
            ("<*" . #XE7E1)
            ("<*>" . #XE7E2)
            ("<+>" . #XE7E3)
            ("<-" . #XE7E4)
            ("<<" . #XE7E5)
            ("<<<" . #XE7E6)
            ("<<=" . #XE7E7)
            ("<=" . #XE7E8)
            ("<=>" . #XE7E9)
            ("<>" . #XE7EA)
            ("<|>" . #XE7EB)
            ("<<-" . #XE7EC)
            ("<|" . #XE7ED)
            ("<=<" . #XE7EE)
            ("<~" . #XE7EF)
            ("<~~" . #XE7F0)
            ("<<~" . #XE7F1)
            ("<$" . #XE7F2)
            ("<+" . #XE7F3)
            ("<!>" . #XE7F4)
            ("<@>" . #XE7F5)
            ("<#>" . #XE7F6)
            ("<%>" . #XE7F7)
            ("<^>" . #XE7F8)
            ("<&>" . #XE7F9)
            ("<?>" . #XE7FA)
            ("<.>" . #XE7FB)
            ("</>" . #XE7FC)
            ("<\>" . #XE7FD)
            ("<\">" . #XE7FE)
            ("<:>" . #XE7FF)
            ("<~>" . #XE800)
            ("<**>" . #XE801)
            ("<<^" . #XE802)
            ("<!" . #XE803)
            ("<@" . #XE804)
            ("<#" . #XE805)
            ("<%" . #XE806)
            ("<^" . #XE807)
            ("<&" . #XE808)
            ("<?" . #XE809)
            ("<." . #XE80A)
            ("</" . #XE80B)
            ("<\\" . #XE80C)
            ("<\"" . #XE80D)
            ("<:" . #XE80E)
            ("<->" . #XE80F)
            ("<!--" . #XE810)
            ("<--" . #XE811)
            ("==<" . #XE820)
            ("==" . #XE821)
            ("===" . #XE822)
            ("==>" . #XE823)
            ("=>" . #XE824)
            ("=~" . #XE825)
            ("=>>" . #XE826)
            ;; ("" . #XE830)
            ;; ("" . #XE831)
            ;; ("" . #XE832)
            (">-" . #XE840)
            (">=" . #XE841)
            (">>" . #XE842)
            (">>-" . #XE843)
            (">==" . #XE844)
            (">>>" . #XE845)
            (">=>" . #XE846)
            (">>^" . #XE847)
            ("??" . #XE860)
            ("?~" . #XE861)
            ("?=" . #XE862)
            ("?>" . #XE863)
            ("^=" . #XE868)
            ("^." . #XE869)
            ("^?" . #XE86A)
            ("^.." . #XE86B)
            ("^<<" . #XE86C)
            ("^>>" . #XE86D)
            ("^>" . #XE86E)
            ("\\\\" . #XE870)
            ("\\>" . #XE871)
            ("@>" . #XE877)
            ("|=" . #XE880)
            ("||" . #XE881)
            ("|>" . #XE882)
            ("|||" . #XE883)
            ("|+|" . #XE884)
            ("~=" . #XE890)
            ("~>" . #XE891)
            ("~~>" . #XE892)
            ("~>>" . #XE893))))

(defun dotspacemacs/user-init ()
  (menu-bar-mode -1)
  (setq-default require-final-newline t)
  (setq auto-completion-return-key-behavior nil
        auto-completion-tab-key-behavior 'complete
        enh-ruby-add-encoding-comment-on-save nil))

(defun dotspacemacs/user-config ()
  (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.mrb$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.js$" . react-mode))
  (add-to-list 'auto-mode-alist '("\\.js.erb$" . react-mode))

  (setq powerline-default-separator nil)
  (spaceline-compile)

  (setq projectile-enable-caching nil
        enable-remote-dir-locals t
        undo-limit 200000
        flycheck-check-syntax-automatically '(save mode-enabled)
        magit-fetch-arguments '("--prune")
        rust-format-on-save t)

  (spacemacs/set-leader-keys "<SPC>" 'avy-goto-word-1)
  (spacemacs/set-leader-keys-for-major-mode 'enh-ruby-mode
    "x=" 'sgnr/ruby-to-new-style-hash)

  (with-eval-after-load 'flycheck
    (flycheck-add-mode 'javascript-eslint 'web-mode))

  (spaceline-toggle-version-control-off)
  (global-hl-line-mode 0)

  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  (add-hook
   'prog-mode-hook
   '(lambda ()
      (setq prettify-symbols-unprettify-at-point t
            prettify-symbols-alist
            (append prettify-symbols-alist sgnr/pragmatapro-font-lock-symbols-alist))
      (prettify-symbols-mode 1)))

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
      (setq evil-shift-width 2)
      (c-toggle-auto-newline 0)
      (c-set-offset 'arglist-intro 2)
      (c-set-offset 'arglist-close 0)
      (c-set-offset 'inextern-lang 0)))

  (add-hook
   'enh-ruby-mode-hook
   '(lambda ()
      (ruby-tools-mode)
      (define-key ruby-tools-mode-map "#" nil)
      (setq enh-ruby-deep-indent-paren nil
            evil-shift-width 2)))

  (add-hook 'rubocop-mode-hook '(lambda () (diminish 'rubocop-mode)))

  (add-hook
   'yaml-mode-hook
   '(lambda ()
      (modify-syntax-entry ?_ "w")))

  (add-hook
   'web-mode-hook
   '(lambda ()
      (let ((file-name (buffer-file-name)))
       (when (and (stringp file-name)
                  (member (file-name-extension file-name) '("js")))
        (sgnr/use-local-eslint)
        (web-mode-set-content-type "jsx")
        (tern-mode 1)))
      (setq web-mode-enable-auto-pairing nil)
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-attr-indent-offset 2)
      (setq web-mode-code-indent-offset 2)))
  (remove-hook 'web-mode-hook 'spacemacs/toggle-smartparens-off)

  (add-hook
   'json-mode-hook
   '(lambda ()
      (setq js-indent-level 2)
      (setq json-reformat:indent-width 2)))

  (setq haskell-process-type 'stack-ghci)
  (setq flycheck-disabled-checkers '(haskell-ghc))
  (add-hook
   'haskell-mode-hook
   '(lambda ()
      (turn-off-smartparens-mode)
      (turn-off-show-smartparens-mode)))

  (add-hook
   'rust-mode-hook
   '(lambda ()
      (setq racer-rust-src-path
            (cond
             ((string-equal system-type "windows-nt")
              "/Users/Simon/Source/github.com/rust-lang/rust/src")
             (t (substitute-in-file-name "$HOME/src/github.com/rust-lang/rust/src"))))))

  (add-hook
   'c-mode-hook
   '(lambda ()
      (setq tab-width 8)))

  (add-hook
   'markdown-mode-hook
   '(lambda ()
      (sp-pair "`" nil :actions :rem))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(exec-path-from-shell-arguments (quote ("-l")))
 '(flycheck-clang-definitions
   (quote
    ("MRB_ENABLE_DEBUG_HOOK" "MRB_INT64" "MRB_UTF8_STRING" "MRB_WORD_BOXING" "YYDEBUG")))
 '(flycheck-clang-include-path
   (list "/opt/rubies/2.3.0/include/ruby-2.3.0/x86_64-darwin15" "/opt/rubies/2.3.0/include/ruby-2.3.0"
         (expand-file-name "~/src/github.com/Shopify/mruby_engine/ext/mruby_engine/mruby/include"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))

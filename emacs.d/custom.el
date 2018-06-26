(defun nh/visit-emacs-custom-config ()
  (interactive)
  (find-file "~/dotfiles/emacs.d/custom.org"))

(global-set-key (kbd "C-x C-,") 'nh/visit-emacs-custom-config)

(defun nh/load-init-file ()
  (interactive)
  (load-file "~/dotfiles/emacs.d/init.el"))

(global-set-key (kbd "C-x C-.") 'nh/load-init-file)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(setq server-name "emacs-server")
(setq server-socket-dir "/tmp/emacs$UID")

(evil-mode t)

(setq evil-want-abbrev-expand-on-insert-exit nil)

(define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)

;; (define-key evil-normal-state-map (kbd "C-n") 'treemacs)

; Bind escape to quit minibuffers
(defun minibuffer-keyboard-quit ()
    "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
    (interactive)
    (if (and delete-selection-mode transient-mark-mode mark-active)
    (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

(when (display-graphic-p)
  (setq evil-emacs-state-cursor '("DarkViolet" box))
  (setq evil-normal-state-cursor '("DodgerBlue" box))
  (setq evil-insert-state-cursor '("LimeGreen" bar))
  (setq evil-motion-state-cursor '("LightSlateBlue" box))
  (setq evil-operator-state-cursor '("VioletRed" hollow))
  (setq evil-visual-state-cursor '("OrangeRed" box))
  (setq evil-replace-state-cursor '("red" bar))
)

(setq evil-normal-state-tag   (propertize " <N> " 'face '((:background "LimeGreen" :foreground "black")))
      evil-emacs-state-tag    (propertize " <E> " 'face '((:background "OrangeRed1"       :foreground "black")))
      evil-insert-state-tag   (propertize " <I> " 'face '((:background "SkyBlue"    :foreground "black")))
      evil-replace-state-tag  (propertize " <R> " 'face '((:background "orchid"      :foreground "black")))
      evil-motion-state-tag   (propertize " <M> " 'face '((:background "plum3"          :foreground "black")))
      evil-visual-state-tag   (propertize " <V> " 'face '((:background "orange"           :foreground "black")))
      evil-operator-state-tag (propertize " <O> " 'face '((:background "gold1"    :foreground "black"))))

(evil-define-key 'normal dired-mode-map (kbd "j") 'dired-next-line)
(evil-define-key 'normal dired-mode-map (kbd "k") 'dired-previous-line)

;; (ido-mode t)

(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(counsel-mode t)
(counsel-projectile-mode t)

(define-key ivy-minibuffer-map (kbd "M-j") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "M-k") 'ivy-previous-line)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq frame-title-format '((:eval (projectile-project-name))))

(setq inhibit-startup-message t)

;; (setq inhibit-x-resources t)

(add-hook 'focus-out-hook (lambda ()
   (when (windowp (active-minibuffer-window))
   (abort-recursive-edit))
   ))

;; (defun nh/set-mode-line-format ()
   ;; (setq-default mode-line-format
       ;; (list
       ;; mode-line-front-space
       ;; evil-mode-line-tag
       ;; " "
       ;; mode-line-frame-identification
       ;; " "
       ;; mode-line-modified
       ;; "["
       ;; mode-line-buffer-identification
       ;; "]  "
       ;; ;; (vc-mode vc-mode)
       ;; mode-line-modes
       ;; " "
       ;; mode-line-position
       ;; mode-line-misc-info
       ;; mode-line-end-spaces
       ;; )
   ;; ))
;; (add-hook 'after-init-hook 'nh/set-mode-line-format)

(defun nh/apply-solarized-theme ()
  (setq solarized-use-variable-pitch nil)
  (setq solarized-height-plus-1 1.0)
  (setq solarized-height-plus-2 1.0)
  (setq solarized-height-plus-3 1.0)
  (setq solarized-height-plus-4 1.0)
  ;; (setq solarized-high-contrast-mode-line t)
  (setq solarized-emphasize-indicators t)
  (setq x-underline-at-descent-line t)
  (load-theme 'solarized-dark t)
  )

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                  (nh/apply-solarized-theme)))
  (nh/apply-solarized-theme))

(setq ring-bell-function 'ignore)

;; (mouse-avoidance-mode 'banish)

(defmacro diminish-minor-mode (filename mode &optional abbrev)
  `(eval-after-load (symbol-name ,filename)
     '(diminish ,mode ,abbrev)))

(defmacro diminish-major-mode (mode-hook abbrev)
  `(add-hook ,mode-hook
             (lambda () (setq mode-name ,abbrev))))

(diminish-minor-mode 'abbrev 'abbrev-mode)
(diminish-minor-mode 'simple 'auto-fill-function)
(diminish-minor-mode 'company 'company-mode)
(diminish-minor-mode 'eldoc 'eldoc-mode)
(diminish-minor-mode 'flycheck 'flycheck-mode)
(diminish-minor-mode 'flyspell 'flyspell-mode)
(diminish-minor-mode 'global-whitespace 'global-whitespace-mode)
(diminish-minor-mode 'projectile 'projectile-mode)
(diminish-minor-mode 'ruby-end 'ruby-end-mode)
(diminish-minor-mode 'subword 'subword-mode)
(diminish-minor-mode 'undo-tree 'undo-tree-mode)
(diminish-minor-mode 'yard-mode 'yard-mode)
(diminish-minor-mode 'yasnippet 'yas-minor-mode)
(diminish-minor-mode 'linum-relative 'linum-relative-mode)
(diminish-minor-mode 'git-gutter 'git-gutter-mode)

(diminish-minor-mode 'paredit 'paredit-mode " π")
(diminish-major-mode 'emacs-lisp-mode-hook "el")
(diminish-major-mode 'haskell-mode-hook "λ=")
(diminish-major-mode 'lisp-interaction-mode-hook "λ")
(diminish-major-mode 'python-mode-hook "")

(setq linum-relative-current-symbol "")
(setq linum-relative-format "%3s ")
(setq linum-relative-global-mode nil)

(require 'linum-relative)
(add-hook 'text-mode-hook (lambda () (linum-relative-mode nil)))
(add-hook 'prog-mode-hook (lambda () (linum-relative-mode t)))
(add-hook 'LaTeX-mode-hook (lambda () (linum-relative-mode t)))
(add-hook 'bibtex-mode-hook (lambda () (linum-relative-mode t)))

;; (add-hook 'org-mode-hook (lambda () (linum-relative-mode nil)))

(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(setq blink-cursor-mode nil)

;; (setq column-number-mode t)

(setq confirm-kill-emacs 'y-or-n-p)

(setq cursor-type 'bar)

(setq cursor-in-non-selected-window 'hbar)

(setq x-stretch-cursor t)

(beacon-mode t)
(setq beacon-push-mark 25)
(setq beacon-color "DodgerBlue")

(defun nh/split-horizontally-for-temp-buffers ()
  (when (one-window-p t)
    (split-window-horizontally)))

(add-hook 'temp-buffer-window-setup-hook
          'nh/split-horizontally-for-temp-buffers)

(global-prettify-symbols-mode t)

(defun nh/split-window-below-and-switch ()
  "Split the window horizontally, then switch to the new window."
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1)
  )
(defun nh/split-window-right-and-switch ()
  "Split the window vertically, then switch to the new window."
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1)
  )

(global-set-key (kbd "C-x 2") 'nh/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'nh/split-window-right-and-switch)

(set-language-environment "UTF-8")

(setq scroll-conservatively 100)

(global-hl-line-mode t)

(show-paren-mode t)

(setq-default tab-width 4)

(global-subword-mode t)

(save-place-mode t)

(setq-default indent-tabs-mode nil)

(add-hook 'LaTeX-mode-hook (lambda () (flyspell-mode t)))
(add-hook 'org-mode-hook (lambda () (flyspell-mode t)))

(add-hook 'prog-mode-hook (lambda () (flyspell-prog-mode t)))

(defun fd-switch-dictionary()
      (interactive)
      (let* ((dic ispell-current-dictionary)
         (change (if (string= dic "english") "brasileiro" "english")))
        (ispell-change-dictionary change)
        (message "Dictionary switched from %s to %s" dic change)
        ))
    
      (global-set-key (kbd "<f8>")   'fd-switch-dictionary)

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'LaTeX-mode-hook (lambda () (visual-line-mode t)))
(add-hook 'LaTeX-mode-hook (lambda () (LaTeX-math-mode t)))
(setq TeX-PDF-mode t)

(add-hook 'org-mode-hook (lambda () (visual-line-mode t)))
(add-hook 'org-mode-hook (lambda () (org-bullets-mode t)))

(setq org-ellipsis " {...}")

(setq org-src-fontify-natively t)

;; (setq org-src-window-setup 'current-window)

(add-to-list 'org-structure-template-alist
             '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (ruby . t)
    (python . t)
    (sh . t)  ; emacs-24 uses sh instead of shell
    (js . t)
    (C . t)))

(setq org-confirm-babel-evaluate nil)

(add-to-list 'org-babel-default-header-args:python
  '(:results . "output"))

(setq org-html-postamble nil)

(setq dired-clean-up-buffers-too t)

(setq dired-recursive-deletes 'top)

;; (require 'git-gutter)
;; (global-git-gutter-mode t)
;; (git-gutter:linum-setup)

;; (custom-set-variables
    ;; '(git-gutter:modified-sign "**") ;; two space
    ;; '(git-gutter:added-sign "++")    ;; multiple character is OK
    ;; '(git-gutter:deleted-sign "--"))

;; (set-face-background 'git-gutter:modified "yellow")
;; (set-face-foreground 'git-gutter:added "green")
;; (set-face-foreground 'git-gutter:deleted "red")

;; (require 'diff-hl)
;; (add-hook 'text-mode-hook 'diff-hl-flydiff-mode)
;; (add-hook 'text-mode-hook 'diff-hl-margin-mode)
;; (add-hook 'text-mode-hook 'diff-hl-mode)
;; (add-hook 'prog-mode-hook 'diff-hl-flydiff-mode)
;; (add-hook 'prog-mode-hook 'diff-hl-margin-mode)
;; (add-hook 'prog-mode-hook 'diff-hl-mode)

;; (require 'telephone-line)

(setq telephone-line-primary-left-separator 'telephone-line-cos-left
      telephone-line-secondary-left-separator 'telephone-line-cos-hollow-left
      telephone-line-primary-right-separator 'telephone-line-cos-right
      telephone-line-secondary-right-separator 'telephone-line-cos-hollow-right)
;; (setq telephone-line-evil-use-short-tag t)

(custom-set-faces
  '(telephone-line-evil-emacs ((t (:inherit telephone-line-evil :background "DarkViolet"))))
  '(telephone-line-evil-normal ((t (:inherit telephone-line-evil :background "MidnightBlue"))))
  '(telephone-line-evil-insert ((t (:inherit telephone-line-evil :background "ForestGreen"))))
  '(telephone-line-evil-motion ((t (:inherit telephone-line-evil :background "DarkSlateBlue"))))
  '(telephone-line-evil-operator ((t (:inherit telephone-line-evil :background "VioletRed"))))
  '(telephone-line-evil-visual ((t (:inherit telephone-line-evil :background "OrangeRed"))))
  '(telephone-line-evil-replace ((t (:inherit telephone-line-evil :background "DarkRed"))))
  )

(telephone-line-mode t)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'auto-complete-config)
(ac-config-default)

;; (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
;; (add-hook 'emacs-lisp-mode-hook                     #'enable-paredit-mode)
;; (add-hook 'eval-expression-minibuffer-setup-hook    #'enable-paredit-mode)
;; (add-hook 'ielm-mode-hook                           #'enable-paredit-mode)
;; (add-hook 'lisp-mode-hook                           #'enable-paredit-mode)
;; (add-hook 'lisp-interaction-mode-hook               #'enable-paredit-mode)
;; (add-hook 'scheme-mode-hook                         #'enable-paredit-mode)
;; (add-hook 'TeX-mode-hook                            #'enable-paredit-mode)
;; (add-hook 'prog-mode-hook                           #'enable-paredit-mode)
;; (global-set-key (kbd "{") 'paredit-open-curly)
;; (global-set-key (kbd "}") 'paredit-close-curly)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'yasnippet)
;; (autoload 'yasnippet "yasnippet" "Select yasnippet" t)
(require 'yasnippet-snippets)
;; (autoload 'yasnippet-snippets "yasnippet-snippets" "Select yasnippet snippets" t)
(yas-reload-all)
;;;; Enable languages snippets
;; (add-hook 'js-mode-hook 'yas-minor-mode)
;; (add-hook 'java-mode-hook 'yas-minor-mode)
;; (add-hook 'python-mode-hook 'yas-minor-mode)
;; (add-hook 'c-mode-hook 'yas-minor-mode)
;; (add-hook 'c++-mode-hook 'yas-minor-mode)
;; (add-hook 'latex-mode-hook 'yas-minor-mode)
(yas-global-mode)

(require 'expand-region)
(global-set-key (kbd "C-q") 'er/expand-region)

;; (require 'magit)
;; (global-set-key (kbd "C-x g") 'magit-status)

(require 'projectile)
(projectile-global-mode t)

;; (require 'helm-config)
;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "M-x") 'helm-M-x)
;; (global-set-key (kbd "C-x b") 'helm-buffers-list)
;; (global-set-key (kbd "C-x r b") 'helm-bookmarks)
;; (global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; (setq helm-default-display-buffer-functions 'display-buffer-in-side-window)

;; (require 'helm-projectile)
;; (helm-projectile-on)

(require 'which-key)
(which-key-mode)

(require 'ace-window)
(global-set-key (kbd "M-g M-w") 'ace-window)
; Set initial window labels
;(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
; Set temporarily background to switch window
;(setq aw-background nil)
; Ignore current window
(setq aw-ignore-current t)

;; (require 'sr-speedbar)

;; (require 'treemacs)

;; ;; jedi
;; (require 'jedi)
;; ;; Hook up to auto-complete
;; (add-to-list 'ac-source 'ac-source-jedi-direct)
;; ;; Enable for python-mode
;; (add-hook 'python-mode-hook 'jedi:setup)

;; ;; Company
;; (require 'company)
;; (setq company-idle-delay 0)
;; (setq company-minimum-prefix-length 1)

;; ;; Change default company navigation keys
;; ;; (with-eval-after-load 'company
;; ;;   (define-key company-active-map (kbd "M-n") nil)
;; ;;   (define-key company-active-map (kbd "M-n") nil)
;; ;;   (define-key company-active-map (kbd "C-n") #'company-select-next)
;; ;;   (define-key company-active-map (kbd "C-p") #'company-select-previous)
;; ;;   )

;; (require 'company-irony)
;; (add-to-list 'company-backends 'company-irony)

;; (require 'irony)
;; (add-hook 'c++-mode-hook (lambda () (irony-mode t)))
;; (add-hook 'c-mode-hook (lambda () (irony-mode t)))
;; (add-hook 'irony-mode-hook (lambda () (irony-cdb-autosetup-compile-options t)))

;; (defun my-latex-mode-setup ()
;;   (setq-local company-backends
;;               (append '((company-math-symbols-latex company-math-symbols-unicode))
;;                       company-backends)))

;; (add-hook 'LaTeX-mode-hook (lambda () (my-latex-mode-setup t)))

;; (with-eval-after-load 'company
;;   (add-hook 'c++-mode-hook 'company-mode)
;;   (add-hook 'c-mode-hook 'company-mode)
;;   (add-hook 'LaTeX-mode-hook 'company-mode)
;;   )

;; ;;;; Helm Swoop
;; (global-set-key (kbd "C-s") 'helm-swoop)
;; (global-set-key (kbd "C-r") 'helm-swoop)
;; (with-eval-after-load 'helm-swoop
;;     (setq helm-swoop-pre-input-function
;;         (lambda () nil)))
;; ;; C-s or C-r in helm-swoop with empty search field: activate previous search.
;; ;; C-s in helm-swoop with non-empty search field: go to next match.
;; ;; C-r in helm-swoop with non-empty search field: go to previous match.
;; (with-eval-after-load 'helm-swoop
;;   (define-key helm-swoop-map (kbd "C-s") 'tl/helm-swoop-C-s))
;; (with-eval-after-load 'helm-swoop
;;   (define-key helm-swoop-map (kbd "C-r") 'tl/helm-swoop-C-r))

;; (defun tl/helm-swoop-C-s ()
;;     (interactive)
;;     (if (boundp 'helm-swoop-pattern)
;;             (if (equal helm-swoop-pattern "")
;;                     (previous-history-element 1)
;;                 (helm-next-line))
;;     (helm-next-line)
;;     ))
;; (defun tl/helm-swoop-C-r ()
;;     (interactive)
;;     (if (boundp 'helm-swoop-pattern)
;;             (if (equal helm-swoop-pattern "")
;;                     (previous-history-element 1)
;;                 (helm-previous-line))
;;     (helm-previous-line)
;;     ))

;; (require 'neotree)
;; (global-set-key (kbd "M-g M-d") 'neotree-show)
;; (global-set-key (kbd "M-g M-h") 'neotree-hide)
;; (global-set-key (kbd "M-g M-r") 'neotree-dir)

;; (require 'perspective)

;; (setq sml/theme 'dark)

;; (setq sml/no-confirm-load-theme t)
;; (sml/setup)
;; (sml/apply-theme 'smart-mode-line-powerline)

;; (require 'powerline)
;; (setq powerline-default-separator "arrow-fade")
;; (powerline-default-theme)

;; (require 'powerline-evil)
;; (powerline-evil-vim-color-theme)

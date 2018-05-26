(require 'package)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; Auto Spell Checker
(add-hook 'text-mode-hook '(lambda () (flyspell-mode t)))
(add-hook 'prog-mode-hook '(lambda () (flyspell-prog-mode t)))

;; Relative Line Numbers
(require 'linum-relative)
(add-hook 'prog-mode-hook '(lambda () (linum-relative-mode t)))
(add-hook 'LaTeX-mode-hook '(lambda () (linum-relative-mode t)))
(add-hook 'text-mode-hook '(lambda () (linum-relative-mode t)))

;; Highlight current line
(global-hl-line-mode t)

;; Highlight matched brackets
(show-paren-mode t)

(setq visible-bell       nil
      ring-bell-function #'ignore)

;; TeX
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook '(lambda () (visual-line-mode t)))
(add-hook 'LaTeX-mode-hook '(lambda () (flyspell-mode t)))
(add-hook 'LaTeX-mode-hook '(lambda () (LaTeX-math-mode t)))
(setq TeX-PDF-mode t)

;; Org-mode
(add-hook 'org-mode-hook '(lambda () (org-bullets-mode t)))
;(setq org-ellipsis "")

(exec-path-from-shell-initialize)

(add-hook 'org-mode-hook '(lambda () (visual-line-mode 1)))

;; Ask for y/n instead of yes/no.
(fset 'yes-or-no-p 'y-or-n-p)

; Set global keybind
; (global-set-key (kbd "<keysequence>") '<command>)

;; Window Resizing
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; Git Gutter
(require 'git-gutter)
(global-git-gutter-mode t)
(git-gutter:linum-setup)

;; (custom-set-variables
;;  '(git-gutter:modified-sign "  ") ;; two space
;;  '(git-gutter:added-sign "++")    ;; multiple character is OK
;;  '(git-gutter:deleted-sign "--"))

(set-face-background 'git-gutter:modified "yellow") ;; background color
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

;; Projectile
(require 'projectile)
(projectile-global-mode t)

;; Multiple Cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Pretty Symbols
(require 'pretty-symbols)
(add-hook 'emacs-lisp-mode-hook '(lambda () (pretty-symbols-mode t)))

;; Active Babel Languages
;(org-babel-do-load-languages
; 'org-babel-load-languages
; (R . t)
; (python . t)
; (C . t)
; (cpp . t)
; (java . t)
; (js . t)
; (latex . t)
; (org . t)
; (sass . t)
; (shell . t)
; )

;; Powerline
(require 'powerline)
(powerline-default-theme)
(setq powerline-default-separator "arrow-fade")

;; Company
(require 'company)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

;; Change default company navigation keys
;; (with-eval-after-load 'company
;;   (define-key company-active-map (kbd "M-n") nil)
;;   (define-key company-active-map (kbd "M-n") nil)
;;   (define-key company-active-map (kbd "C-n") #'company-select-next)
;;   (define-key company-active-map (kbd "C-p") #'company-select-previous)
;;   )

(require 'company-irony)
(add-to-list 'company-backends 'company-irony)

(require 'irony)
(add-hook 'c++-mode-hook '(lambda () (irony-mode t)))
(add-hook 'c-mode-hook '(lambda () (irony-mode t)))
(add-hook 'irony-mode-hook '(lambda () (irony-cdb-autosetup-compile-options t)))

(defun my-latex-mode-setup ()
  (setq-local company-backends
              (append '((company-math-symbols-latex company-math-symbols-unicode))
                      company-backends)))

(add-hook 'LaTeX-mode-hook '(lambda () (my-latex-mode-setup t)))

(with-eval-after-load 'company
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode)
  (add-hook 'LaTeX-mode-hook 'company-mode)
  )

;; Paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook                     #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook    #'enable-paredit-mode)
(add-hook 'ielm-mode-hook                           #'enable-paredit-mode)
(add-hook 'lisp-mode-hook                           #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook               #'enable-paredit-mode)
(add-hook 'scheme-mode-hook                         #'enable-paredit-mode)
(add-hook 'TeX-mode-hook                            #'enable-paredit-mode)
(add-hook 'prog-mode-hook                           #'enable-paredit-mode)
(global-set-key (kbd "{") 'paredit-open-curly)
(global-set-key (kbd "}") 'paredit-close-curly)

;; Rainbow Delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Yasnippet
(require 'yasnippet)
;(autoload 'yasnippet "yasnippet" "Select yasnippet" t)
(require 'yasnippet-snippets)
;(autoload 'yasnippet-snippets "yasnippet-snippets" "Select yasnippet snippets" t)
(yas-reload-all)
;;;; Enable languages snippets
;(add-hook 'js-mode-hook 'yas-minor-mode)
;(add-hook 'java-mode-hook 'yas-minor-mode)
;(add-hook 'python-mode-hook 'yas-minor-mode)
;(add-hook 'c-mode-hook 'yas-minor-mode)
;(add-hook 'c++-mode-hook 'yas-minor-mode)
;(add-hook 'latex-mode-hook 'yas-minor-mode)
(yas-global-mode)

;; mark-multiple
;(require 'mark-multiple)
;(global-set-key (kbd "C-c q") 'mark-next-like-this)

;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-q") 'er/expand-region)

;; Magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; Ivy
;(ivy-mode 1)
;(global-set-key (kbd "C-s") 'swiper)
;(global-set-key (kbd "M-x") 'counsel-M-x)
;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;(global-set-key (kbd "<f1> f") 'counsel-describe-function)
;(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;(global-set-key (kbd "<f1> l") 'counsel-find-library)
;(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;(global-set-key (kbd "<f2> u") 'counsel-unicode-char)

;; Helm
(require 'helm-config)
;(define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

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

;; which-key
(require 'which-key)
(which-key-mode)

;; ace-window
(require 'ace-window)
(global-set-key (kbd "M-g M-w") 'ace-window)
; Set initial window labels
;(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
; Set temporarily background to switch window
;(setq aw-background nil)
; Ignore current window
(setq aw-ignore-current t)

;; Neotree
(require 'neotree)
(global-set-key (kbd "M-g M-d") 'neotree-show)
(global-set-key (kbd "M-g M-h") 'neotree-hide)
(global-set-key (kbd "M-g M-r") 'neotree-dir)

;; Perspective
;(require 'perspective)

;; then in your init you can load all of the themes
;; without enabling theme (or just load one)
;(load-theme 'ample t t)
;(load-theme 'ample-flat t t)
;(load-theme 'ample-light t t)
;; choose one to enable
;(enable-theme 'ample)
;; (enable-theme 'ample-flat)
;; (enable-theme 'ample-light)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(ansi-term-color-vector
   [unspecified "#212121" "#f07178" "#c3e88d" "#ffcb6b" "#82aaff" "#c792ea" "#82aaff" "#eeffff"] t)
 '(aw-ignore-current t)
 '(beacon-color "#cc6666")
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face (quote default))
 '(confirm-kill-emacs (quote y-or-n-p))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(cursor-in-non-selected-windows (quote hbar))
 '(cursor-type (quote bar))
 '(custom-enabled-themes (quote (atom-one-dark)))
 '(custom-safe-themes
   (quote
    ("1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "bf798e9e8ff00d4bf2512597f36e5a135ce48e477ce88a0764cfb5d8104e8163" "77bd459212c0176bdf63c1904c4ba20fce015f730f0343776a1a14432de80990" "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "8891c81848a6cf203c7ac816436ea1a859c34038c39e3cf9f48292d8b1c86528" "a566448baba25f48e1833d86807b77876a899fc0c3d33394094cf267c970749f" "2c88b703cbe7ce802bf6f0bffe3edbb8d9ec68fc7557089d4eaa1e29f7529fe1" "a156fcac344bbfdc979a5adf9cecf1c2de56c4c937549ae0571b7f11ad4fe6a9" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "ce3e6c12b48979ce89754884d913c7ecc8a7956543d8b09ef13abfab6af9aa35" "3a3de615f80a0e8706208f0a71bbcc7cc3816988f971b6d237223b6731f91605" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da" "c3d4af771cbe0501d5a865656802788a9a0ff9cf10a7df704ec8b8ef69017c68" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "5f4e4c9f5de8156f964fdf8a1b8f8f659efbfeff88b38f49ce13953a84272b77" "3d5720f488f2ed54dd4e40e9252da2912110948366a16aef503f3e9e7dfe4915" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "7feeed063855b06836e0262f77f5c6d3f415159a98a9676d549bfeb6c49637c4" "e88abed2a39b47dfedb1272066f214cb2c9db28ee6aa1794bfb27948792f81c0" "9fe1540491fcf692b8c639a3abacd32b29233bc4cb834a12a0fd1e01cbd0a128" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3" "fc7fd2530b82a722ceb5b211f9e732d15ad41d5306c011253a0ba43aaf93dccc" "cabc32838ccceea97404f6fcb7ce791c6e38491fd19baa0fcfb336dcc5f6e23c" "5d3e0746023fc5e246eb3e0e48c1ccb5ce0387fc4273896c6cf02ee349c2eba8" "6332c9756bde31cf9e34154395868413e45714488507527969f95a61b5f24518" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "bc40f613df8e0d8f31c5eb3380b61f587e1b5bc439212e03d4ea44b26b4f408a" "57fe2bf84d81baecc6d89ed97bdb19936a3052fc2551ca178667fc45feef2381" "a632c5ce9bd5bcdbb7e22bf278d802711074413fd5f681f39f21d340064ff292" "1d079355c721b517fdc9891f0fda927fe3f87288f2e6cc3b8566655a64ca5453" "196df8815910c1a3422b5f7c1f45a72edfa851f6a1d672b7b727d9551bb7c7ba" "f2dd097452b79276ce522df2f8aeb37f6d90f504529616aa46122d549910e46d" "78c1c89192e172436dbf892bd90562bc89e2cc3811b5f9506226e735a953a9c6" "aea30125ef2e48831f46695418677b9d676c3babf43959c8e978c0ad672a7329" "a62f0662e6aa7b05d0b4493a8e245ab31492765561b08192df61c9d1c7e1ddee" "081d0f8a263358308245355f0bb242c7a6726fc85f0397d65b18902ea95da591" "7e1fa2fd97e792390d0c2347f0eefa2d1679c68da56e6baf983b057cefa400b4" "d5b121d69e48e0f2a84c8e4580f0ba230423391a78fcb4001ccb35d02494d79e" "604648621aebec024d47c352b8e3411e63bdb384367c3dd2e8db39df81b475f5" "9b402e9e8f62024b2e7f516465b63a4927028a7055392290600b776e4a5b9905" "551596f9165514c617c99ad6ce13196d6e7caa7035cea92a0e143dbe7b28be0e" "718fb4e505b6134cc0eafb7dad709be5ec1ba7a7e8102617d87d3109f56d9615" "f41ecd2c34a9347aeec0a187a87f9668fa8efb843b2606b6d5d92a653abe2439" "eea01f540a0f3bc7c755410ea146943688c4e29bea74a29568635670ab22f9bc" "6ac7c0f959f0d7853915012e78ff70150bfbe2a69a1b703c3ac4184f9ae3ae02" "3fa81193ab414a4d54cde427c2662337c2cab5dd4eb17ffff0d90bca97581eb6" "42b9d85321f5a152a6aef0cc8173e701f572175d6711361955ecfb4943fe93af" "ed0b4fc082715fc1d6a547650752cd8ec76c400ef72eb159543db1770a27caa7" "021720af46e6e78e2be7875b2b5b05344f4e21fad70d17af7acfd6922386b61e" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(emacs-lisp-docstring-fill-column 8)
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #1ba1a1\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(ensime-sem-high-faces
   (quote
    ((var :foreground "#9876aa" :underline
          (:style wave :color "yellow"))
     (val :foreground "#9876aa")
     (varField :slant italic)
     (valField :foreground "#9876aa" :slant italic)
     (functionCall :foreground "#a9b7c6")
     (implicitConversion :underline
                         (:color "#808080"))
     (implicitParams :underline
                     (:color "#808080"))
     (operator :foreground "#cc7832")
     (param :foreground "#a9b7c6")
     (class :foreground "#4e807d")
     (trait :foreground "#4e807d" :slant italic)
     (object :foreground "#6897bb" :slant italic)
     (package :foreground "#cc7832")
     (deprecated :strike-through "#a9b7c6"))))
 '(fci-rule-character-color "#202020")
 '(fci-rule-color "#3E4451")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(fringe-mode 8 nil (fringe))
 '(global-linum-mode nil)
 '(gnus-logo-colors (quote ("#4c8383" "#bababa")) t)
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #1ba1a1\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")) t)
 '(helm-boring-buffer-regexp-list
   (quote
    ("\\` " "\\`\\*helm" "\\`\\*Echo Area" "\\`\\*Minibuf" "\\`\\*Completions")))
 '(helm-default-display-buffer-alist nil)
 '(helm-default-display-buffer-functions (quote (display-buffer-in-side-window)))
 '(helm-display-buffer-reuse-frame nil)
 '(helm-mm-matching-method (quote multi1))
 '(highlight-changes-colors (quote ("#ff8eff" "#ab7eff")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#424748" . 0)
     ("#63de5d" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#424748" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(ido-enable-flex-matching t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(jdee-db-active-breakpoint-face-colors (cons "#0d0f11" "#7FC1CA"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d0f11" "#A8CE93"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d0f11" "#899BA6"))
 '(linum-format "%4d ")
 '(linum-relative-current-symbol "")
 '(linum-relative-format "%3s ")
 '(linum-relative-global-mode nil)
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(menu-bar-mode nil)
 '(notmuch-search-line-faces
   (quote
    (("unread" :foreground "#aeee00")
     ("flagged" :foreground "#0a9dff")
     ("deleted" :foreground "#ff2c4b" :bold t))))
 '(nrepl-message-colors
   (quote
    ("#ee11dd" "#8584ae" "#b4f5fe" "#4c406d" "#ffe000" "#ffa500" "#ffa500" "#DC8CC3")))
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (git-gutter ample-zen-theme android-mode angular-mode anki-editor use-package ample-theme doom-themes selected smartparens color-theme-sanityinc-tomorrow alect-themes cyberpunk-theme grandshell-theme hemisu-theme sokoban solarized-theme zenburn-theme darcula-theme darkokai-theme monochrome-theme monokai-theme ob-applescript ob-async ob-browser ob-ipython ob-kotlin ob-mongo ob-prolog ob-sql-mode ob-translate ob-typescript org-brain org-dashboard helm-bibtex helm-company smart-mode-line smart-mode-line-powerline-theme multiple-cursors dracula-theme helm-descbinds helm-emms helm-ls-git helm-ls-hg helm-swoop helm-themes helm-youtube 2048-game systemd spaceline neotree better-shell demo-it dumb-jump flymake-cppcheck flymake-css flymake-jshint flymake-jslint flymake-json flymake-less flymake-lua flymake-php flymake-python-pyflakes flymake-ruby flymake-sass flymake-shell jdee pretty-symbols company-jedi company-math jedi org-babel-eval-in-repl org-bullets hacker-typer which-key counsel counsel-projectile ivy-bibtex ivy-yasnippet persp-projectile helm-projectile org-projectile auctex company-auctex company-bibtex ace-window perspective rainbow-blocks magit seti-theme sexy-monochrome-theme soothe-theme spacemacs-theme zerodark-theme zweilight-theme abyss-theme badger-theme badwolf-theme blackboard-theme danneskjold-theme atom-one-dark-theme flatui-dark-theme klere-theme monokai-alt-theme rainbow-mode mark-multiple yasnippet-snippets yasnippet expand-region company-irony irony ivy arjen-grey-theme paredit rainbow-delimiters swiper company powerline lorem-ipsum linum-relative exec-path-from-shell projectile clojure-mode-extra-font-locking cider gruvbox-theme)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#E6DB74")
 '(pos-tip-foreground-color "#242728")
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(prog-mode-hook (quote (linum-relative-mode)))
 '(scroll-bar-mode nil)
 '(shell-file-name "/bin/zsh")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(tab-always-indent nil)
 '(tab-width 4)
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(vc-annotate-background "#0bafed")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#ee11dd")
     (60 . "#8584ae")
     (80 . "#ffe000")
     (100 . "#efef80")
     (120 . "#b4f5fe")
     (140 . "#4c406d")
     (160 . "#4c406d")
     (180 . "#1b1a24")
     (200 . "#4c406d")
     (220 . "#65ba08")
     (240 . "#ffe000")
     (260 . "#ffa500")
     (280 . "#6CA0A3")
     (300 . "#0bafed")
     (320 . "#8CD0D3")
     (340 . "#ffa500")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(visual-line-fringe-indicators (quote (nil nil)))
 '(weechat-color-list
   (unspecified "#242728" "#424748" "#F70057" "#ff0066" "#86C30D" "#63de5d" "#BEB244" "#E6DB74" "#40CAE4" "#06d8ff" "#FF61FF" "#ff8eff" "#00b2ac" "#53f2dc" "#f8fbfc" "#ffffff"))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#0b0c0f" :weight semi-bold :height 98 :width normal :foundry "ADBO" :family "Hasklig"))))
 '(aw-key-face ((t (:inherit font-lock-builtin-face :weight normal :height 10 :width extra-expanded :family "Exo 2"))))
 '(cursor ((t (:background "gray" :foreground "black"))))
 '(fringe ((t (:background "#0b0c0f" :foreground "gray15"))))
 '(helm-ff-directory ((t (:background "#0b0c0f" :foreground "#56B6C2" :weight bold))))
 '(helm-ff-dotted-directory ((t (:background "#0b0c0f" :foreground "dim gray"))))
 '(helm-ff-dotted-symlink-directory ((t (:background "#0b0c0f" :foreground "DarkOrange"))))
 '(helm-ff-executable ((t (:background "#0b0c0f" :foreground "#98C379" :weight normal))))
 '(helm-ff-file ((t (:background "#0b0c0f" :foreground "#ABB2BF" :weight normal))))
 '(helm-ff-invalid-symlink ((t (:background "#0b0c0f" :foreground "#E06C75" :weight bold))))
 '(helm-ff-symlink ((t (:background "#0b0c0f" :foreground "#E5C07B" :weight bold))))
 '(helm-source-header ((t (:background "#282C34" :foreground "white" :box (:line-width 6 :color "#282C34") :underline nil :weight bold :height 1.3 :family "Source Code Pro"))))
 '(linum ((t (:background "#0b0c0f" :foreground "#4B5363"))))
 '(trailing-whitespace ((t (:background "#fb4933")))))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


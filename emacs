                                        ; ================================================
                                        ;                ESSENTIAL CONFIGS
                                        ; ================================================
(menu-bar-mode -1)
(ido-mode)
(column-number-mode)
(show-paren-mode)

(xterm-mouse-mode 1)

(setq-default indent-tabs-mode nil)
(electric-pair-mode 1)

(when (fboundp 'electric-indent-mode) (electric-indent-mode -1)) ; Disable electric-indent-mode

(global-hl-line-mode)

(global-linum-mode 1)
(setq linum-format "%d ")

(winner-mode t)
(windmove-default-keybindings)

(setq neo-smart-open t)

(global-auto-revert-mode 1)

(setq tab-width 4) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(setq x-select-enable-clipboard t) ; to be able to copy to clipboard


(setq-default c-basic-offset 4)
                                        ; style I want to use in c++ mode
(c-add-style "my-style" 
	     '("stroustrup"
	       (indent-tabs-mode . nil)        ; use spaces rather than tabs
	       (c-basic-offset . 4)            ; indent by four spaces
	       (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
				   (brace-list-open . 0)
				   (statement-case-open . +)))))

(defun my-c++-mode-hook ()
  (c-set-style "my-style")        ; use my-style defined above
  (auto-fill-mode)         
  (c-toggle-auto-hungry-state 1))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

                                        ; ================================================
                                        ;                   BINDING/MAPPING
                                        ; ================================================
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-commad)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)

(global-set-key [f10] 'neotree-toggle)
(global-set-key [f11] 'helm-projectile)
(global-set-key [f12] 'helm-projectile-grep)

                                        ; ================================================
                                        ;               JAVASCRIPT/WEB MODES 
                                        ; ================================================
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-comment-keywords t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
(add-hook 'js2-jsx-mode-hook #'js2-refactor-mode)

(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

                                        ; ================================================
                                        ;               PYTHON MODES 
                                        ; ================================================
(setq flymake-python-pyflakes-executable "flake8")


                                        ; ================================================
                                        ;               YAML MODES 
                                        ; ================================================
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook 'flymake-yaml-load)
                                        ; ================================================
                                        ;                   BACKUPS
                                        ; ================================================
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs-backups"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups


                                        ; ================================================
                                        ;                   TAGS
                                        ; ================================================
(setq path-to-ctags "/usr/bin/ctags")

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f TAGS -R %s" path-to-ctags (dir-name)))
  )

                                        ; ================================================
                                        ;                   APACHE-MODE
                                        ; ================================================
(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

                                        ; ================================================
                                        ;                   PACKAGES
                                        ; ================================================
(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository
(add-to-list 'package-archives '("elpy" . "http://jorgenschaefer.github.io/packages/")) ; package-install elpy

(package-initialize)
; (package-refresh-contents)
(elpy-enable)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (foggy-night)))
 '(custom-safe-themes
   (quote
    ("70403e220d6d7100bae7775b3334eddeb340ba9c37f4b39c189c2c29d458543b" "f9574c9ede3f64d57b3aa9b9cef621d54e2e503f4d75d8613cbcc4ca1c962c21" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "2997ecd20f07b99259bddba648555335ffb7a7d908d8d3e6660ecbec415f6b95" "1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "6de7c03d614033c0403657409313d5f01202361e35490a3404e33e46663c2596" "ed317c0a3387be628a48c4bbdb316b4fa645a414838149069210b66dd521733f" "938d8c186c4cb9ec4a8d8bc159285e0d0f07bad46edf20aa469a89d0d2a586ea" "6f441c0e5d8199f08eb4b73e9c697710282bcae95e5925b7649ddfa8cea2e24c" "ba9be9caf9aa91eb34cf11ad9e8c61e54db68d2d474f99a52ba7e87097fa27f5" "12b7ed9b0e990f6d41827c343467d2a6c464094cbcc6d0844df32837b50655f9" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "9d4787fa4d9e06acb0e5c51499bff7ea827983b8bcc7d7545ca41db521bd9261" "db2ecce0600e3a5453532a89fc19b139664b4a3e7cbefce3aaf42b6d9b1d6214" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "9d91458c4ad7c74cf946bd97ad085c0f6a40c370ac0a1cbeb2e3879f15b40553" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "d5b121d69e48e0f2a84c8e4580f0ba230423391a78fcb4001ccb35d02494d79e" "d606ac41cdd7054841941455c0151c54f8bff7e4e050255dbd4ae4d60ab640c1" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "01ce486c3a7c8b37cf13f8c95ca4bb3c11413228b35676025fdf239e77019ea1" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "c7a9a68bd07e38620a5508fef62ec079d274475c8f92d75ed0c33c45fbe306bc" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (go-projectile go-complete go-playground-cli markdown-mode flymd go-autocomplete go go-playground golint google-c-style monochrome-theme json-mode jedi-direx jedi epc yaml-mode flymake-yaml python-mode flymake-python-pyflakes darkokai-theme color-theme-monokai abyss-theme alect-themes ample-zen-theme apache-mode ample-theme ahungry-theme eslint-fix json-rpc helm-projectile helm-core helm-ag-r helm ac-helm project-explorer js3-mode jsx-mode yafolding shell-switcher smooth-scrolling smooth-scroll firebelly-theme meacupla-theme js2-mode ac-js2 smart-tabs-mode smart-tab flex-autopair yoshi-theme smart-mode-line-powerline-theme simplezen discover-js2-refactor arjen-grey-theme js-auto-beautify react-snippets tangotango-theme zenburn-theme blackboard-theme ac-html-csswatcher ac-html-bootstrap ac-html-angular folding magit commenter smart-comment html-check-frag company-web auto-indent-mode autopair neotree foggy-night-theme color-theme-solarized color-theme-sanityinc-tomorrow aurora-config-mode reykjavik-theme python-django monokai-theme tidy helm-smex auto-auto-indent ascii angular-snippets angular-mode ace-link abl-mode ac-clang ac-etags ac-html ac-ispell ac-python ac-slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-preprocessor-face ((t (:background "black")))))

(ac-config-default)

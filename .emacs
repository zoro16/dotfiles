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
(setq multi-term-program "/bin/zsh")
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

(global-set-key [f7] 'neotree-toggle)
(global-set-key [f8] 'helm-projectile)
(global-set-key [f9] 'helm-projectile-grep)

                                        ; ================================================
                                        ;               JAVASCRIPT/WEB MODES 
                                        ; ================================================
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-comment-keywords t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)

(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))

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
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

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
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(package-selected-packages
   (quote
    (solidity-mode swift3-mode swift-mode cmake-mode docker-compose-mode react-snippets flymake-shell flymake-python-pyflakes flymake-jshint flymake-go flymake-gjshint flymake-cppcheck flycheck-irony flycheck-yamllint js-format jist javadoc-lookup jastadd-ast-mode jasminejs-mode jar-manifest-mode java-snippets java-imports neotree karma js-auto-beautify jst jsx-mode magit-imerge magit markdown-mode+ markdown-mode all ac-php ac-ispell web-mode web-beautify vue-mode vue-html-mode ranger python-django python pylint pygen org-beautify-theme org-ac org helm-aws helm-flyspell helm-mt android-mode ansible ac-js2 ac-html-bootstrap ac-html-angular ac-html json-reformat json-navigator json-mode js2-highlight-vars js2-refactor jdee jedi-direx jenkins-watch jenkins jedi haskell-mode helm-projectile helm ac-helm elpy multi-term js2-mode apache-mode color-theme-molokai color-theme-solarized ac-python ac-slime solarized-theme smex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(ac-config-default)

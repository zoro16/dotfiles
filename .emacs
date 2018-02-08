;; ================================================
;;                ESSENTIAL CONFIGS
;; ================================================

(menu-bar-mode -1)
(ido-mode)
(column-number-mode)
(show-paren-mode)
(setq highlight-indentation-mode 1)
(add-hook 'prog-mode-hook 'highlight-indentation-mode)
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
;                   WEB MODES
; ================================================
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-comment-keywords t)

; ================================================
;               JAVASCRIPT MODES
; ================================================
;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))

;; use eslint with web-mode for jsx files
;; (flycheck-add-mode 'javascript-eslint 'rjsx-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

(defadvice js-jsx-indent-line (after js-jsx-indent-line-after-hack activate)
  "Workaround sgml-mode and follow airbnb component style."
  (save-excursion
    (beginning-of-line)
    (if (looking-at-p "^ +\/?> *$")
        (delete-char sgml-basic-offset))))

(with-eval-after-load 'rjsx-mode
  (define-key rjsx-mode-map "<" nil)
  (define-key rjsx-mode-map (kbd "C-d") nil)
  (define-key rjsx-mode-map ">" nil))


(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)

(add-hook 'rjsx-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

; ================================================
;               TYPESCRIPT MODES
; ================================================
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-hook 'typescript-mode-hook 'tide-mode)

(add-hook 'typescript-mode-hook
          (lambda ()
            (local-set-key (kbd "C-x C-e") 'ts-send-last-sexp)
            (local-set-key (kbd "C-M-x") 'ts-send-last-sexp-and-go)
            (local-set-key (kbd "C-c b") 'ts-send-buffer)
            (local-set-key (kbd "C-c C-b") 'ts-send-buffer-and-go)
            (local-set-key (kbd "C-c l") 'ts-load-file-and-go)))

; ================================================
;               PYTHON MODES
; ================================================
(setq flymake-python-pyflakes-executable "flake8")


; ================================================
;               MARKDOWN MODES
; ================================================
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


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
;; (package-refresh-contents)
(elpy-enable)

(package-install 'flycheck)
(global-flycheck-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" solarized-dark)))
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (multi-term highlight-indentation neotree smex markdown-mode apache-mode abl-mode ac-helm ac-html ac-ispell ac-js2 ac-math ac-php ac-php-core ace-flyspell ace-isearch auto-highlight-symbol company-go company-jedi docker-compose-mode dockerfile-mode flymake-python-pyflakes flymake-yaml flyspell-correct flyspell-correct-helm foggy-night-theme helm-aws helm-projectile idle-highlight-mode ido-completing-read+ iedit jedi jedi-core jedi-direx jenkins jenkins-watch js2-mode js2-refactor json-mode magit mmm-mode mocha mocha-snippets mongo monokai-alt-theme monokai-theme ng2-mode nginx-mode org org-ac org-agenda-property org-alert org-autolist org-board org-brain org-bullets org-caldav org-preview-html org-projectile org-projectile-helm org-protocol-jekyll org-random-todo org-randomnote org-repo-todo org-review org-static-blog org-sticky-header org-super-agenda org-sync python python-cell python-django python-docstring python-environment python-info python-mode pyvenv rjsx-mode solarized-theme tide ts-comint tss typescript-mode vue-mode web-beautify web-completion-data web-mode web-server websocket)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 91 :width normal)))))

(ac-config-default)
(put 'upcase-region 'disabled nil)

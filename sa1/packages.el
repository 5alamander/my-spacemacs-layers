;;; packages.el --- sa1 Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
 (setq sa1-packages
    '(
      ;; package names go here
      paredit
      bookmark+
      ;; windmove
      ;; hydra with org
      ;; plantuml-mode
      ;; puml-mode
      ;; slime-company
      ))

;; List of packages to exclude.
(setq sa1-excluded-packages '())

;; For each package, define a function sa1/init-<package-name>

(defun sa1/init ()
  "run some function"
  (message "my-log:: sa1/init-my-package")

  ;; (slime-setup '(slime-fancy slime-company))

  ;; paren-mode
  (show-paren-mode)

  ;; set a global key
  (global-set-key (kbd "C-c TAB") 'sa1-yasnippet-current-line)
  (define-key yas-minor-mode-map (kbd "<C-tab>") 'helm-yas-complete)
  (global-set-key [M-f12] (case system-type
                            ('windows-nt 'sa1-open-buffer-path)
                            ('darwin 'sa1-open-buffer-path-osx)))
  ;; TODO for windows and mac
  (global-set-key [f9] 'sa1-open-directory-shell)
  ;; TODO yes-or-no-p alternative operation
  ;; (global-set-key [f10] 'delete-frame)

  ;; when windows
  (when (eq system-type 'windows-nt)
    ;; js tern mode path
    (setq tern-command                  ; the default is '("node" "tern")
          '("node" "C:\\Users\\User\\AppData\\Roaming\\npm\\node_modules\\tern\\bin\\tern"))
    ;; integrate plantuml with org
    ;; open the image mode
    (auto-image-file-mode t)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (plantuml . t)))
    (setq org-plantuml-jar-path
          (expand-file-name "~/.otherTools/plantuml.jar")))

  ;; set evil key-binding
  (define-key evil-emacs-state-map (kbd "C-w") 'sa1-cut-line-or-region)
  (define-key evil-hybrid-state-map (kbd "C-w") 'sa1-cut-line-or-region)
  (define-key evil-normal-state-map (kbd "C-s") 'save-buffer)
  )

;; (defun sa1/init-puml-mode ()
;;   "Initialize plantuml-mode"
;;   (use-package puml-mode
;;     :init
;;     (progn
;;       (message "my-log:: sa1/init-plantuml-mode init")
;;       (setq puml-plantuml-jar-path "~/.otherTools/plantuml.jar")))
;;   )

(defun sa1/init-paredit ()
  "Initialize my package"
  (use-package paredit
    :init
    (progn
      (message "my-log:: sa1/paredit init")
      (add-hook 'emacs-lisp-mode-hook 'paredit-mode)))
    :config
    (progn
      (message "my-log:: sa1/paredit config")))

(defun sa1/init-bookmark+ ()
  "Initialize bookmark+"
  (use-package bookmark+
    :init
    (progn
      (message "my-log:: sa1/bookmark+ config")
      ;; set the path before load
      (setq bookmark-default-file "~/.emacs.d/.cache/bookmarks")))
  )

;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

;;; my favg mode
;;; "Sin\\|Cos\\|Sum" means #"Sin|Cos|Sum" in clojure
(setq sa1//favg-star-prefix
      "^[[:space:]]*\\(\\*\\)")

(setq sa1//favg-dialog-regex
      (concat sa1//favg-star-prefix "\\(.*[:：]\\)\\(.*\\)"))

(setq sa1//favg-func-regex
      (concat sa1//favg-star-prefix "[[:space:]]*\\([[:word:]]*\\)\\(.*\\)"))

;;; highlight key word of macro
;;; TODO use keyword instead
(setq sa1//favg-form-regex
      (concat sa1//favg-star-prefix
              "[[:space:]]*\\(if\\|when\\|seq\\|choice\\|flag\\)"))

(setq sa1//favg-array-regex
      (concat sa1//favg-star-prefix "[[:space:]]*\\(\\[.*\\]\\)"))

(setq sa1-favg-highlights
      `((,sa1//favg-star-prefix 1 'font-lock-comment-face)
        ;; (,sa1//favg-form-regex 2 'font-lock-keyword-face)
        (,sa1//favg-dialog-regex 2 'font-lock-function-name-face)
        (,sa1//favg-dialog-regex 3 'font-lock-string-face)
        (,sa1//favg-func-regex 2 'font-lock-builtin-face)
        (,sa1//favg-array-regex 2 'font-lock-variable-name-face)
        (,sa1//favg-func-regex 3 'font-lock-variable-name-face)
        ))

;;; attach this to markdown-mode
(define-minor-mode sa1-favg-mode
  "Doc string, My first mode"
  nil "favg" nil
  (font-lock-add-keywords nil sa1-favg-highlights)
  (if (fboundp 'font-lock-flush);; flush buffer?
      (font-lock-flush)
    (when font-lock-mode
      (with-no-warnings (font-lock-fontify-buffer)))))

;;; clear memory, no longer needed
(setq sa1//favg-star-prefix nil)
(setq sa1//favg-dialog-regex nil)
(setq sa1//favg-func-regex nil)
(setq sa1//favg-form-regex nil)
(setq sa1//favg-array-regex nil)

;;; packages.el --- sa1-tabbar layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: byy <Salamander@byydeMacBook-Pro.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `sa1-tabbar-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `sa1-tabbar/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `sa1-tabbar/pre-init-PACKAGE' and/or
;;   `sa1-tabbar/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

;;; TODO: delete this layer
(defconst sa1-tabbar-packages
  '(
    tabbar
    tabbar-ruler
    )
  "The list of Lisp packages required by the sa1-tabbar layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format"
  )

;; (defun sa1-tabbar/init-tabbar ()
;;   "Initialize tabbar"
;;   (use-package tabbar
;;     :init
;;     (progn
;;       (message "my-log:: sa1-tabbar/init"))
;;     :config
;;     (progn
;;       (tabbar-mode t)
;;       (message "my-log:: sa1-tabbar/config")
;;       ;; set face of tabbar
;;       (setq tabbar-background-color nil)
;;       (setq tabbar-use-images nil)
;;       (setq tabbar-unselected '((t (:inherit nil :stipple nil :background "steel blue" :foreground "#282C34" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "outline" :family "Source Code Pro"))))
;;       (setq tabbar-unselected-modified '((t (:inherit tabbar-unselected :foreground "dark red" :weight bold))))
;;       )))

(defun sa1-tabbar/init-tabbar ()
  "Initialize tabbar"
  (use-package tabbar
    :init
    (tabbar-mode 1)
    (setq tabbar-use-images nil)
    (set-face-attribute 'tabbar-default nil
                        :background "gray20"
                        :foreground "gray20"
                        :box '(:line-width 1 :color "gray20" :style nil))
    (set-face-attribute 'tabbar-unselected nil
                        :background "gray30"
                        :foreground "white"
                        :box '(:line-width 5 :color "gray30" :style nil))
    (set-face-attribute 'tabbar-selected nil
                        :background "gray75"
                        :foreground "black"
                        :box '(:line-width 5 :color "gray75" :style nil))
    (set-face-attribute 'tabbar-highlight nil
                        :background "white"
                        :foreground "black"
                        :underline nil
                        :box '(:line-width 5 :color "white" :style nil))
    (set-face-attribute 'tabbar-button nil
                        :box '(:line-width 1 :color "gray20" :style nil))
    (set-face-attribute 'tabbar-separator nil
                        :background "gray20"
                        :height 0.6)
    ;; Change padding of the tabs
    ;; we also need to set separator to avoid overlapping tabs by highlighted tabs
    (custom-set-variables
     '(tabbar-separator (quote (0.5))))
    ;; adding spaces
    (defun tabbar-buffer-tab-label (tab)
      "Return a label for TAB.
That is, a string used to represent it on the tab bar."
      (let ((label  (if tabbar--buffer-show-groups
                        (format "[%s]  " (tabbar-tab-tabset tab))
                      (format "%s  " (tabbar-tab-value tab)))))
        ;; Unless the tab bar auto scrolls to keep the selected tab
        ;; visible, shorten the tab label to keep as many tabs as possible
        ;; in the visible area of the tab bar.
        (if tabbar-auto-scroll-flag
            label
          (tabbar-shorten
           label (max 1 (/ (window-width)
                           (length (tabbar-view
                                    (tabbar-current-tabset)))))))))
    )
  )

(defun sa1-tabbar/init-tabbar-ruler ()
  :init
  (message "my-log:: sa1-tabbar-ruler/config")
  :config
  (message "my-log:: sa1-tabbar-ruler/config")
  )

;;; packages.el ends here

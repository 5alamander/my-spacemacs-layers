;;; packages.el --- byy/scheme layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: byy <Salamander@Sa1Mac.local>
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
;; added to `byy/scheme-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `byy/scheme/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `byy/scheme/pre-init-PACKAGE' and/or
;;   `byy/scheme/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst byy-scheme-packages
  '(geiser paredit))

(defun byy-scheme/post-init-paredit ()
  ;; scheme mode use paredit
  (add-hook 'scheme-mode-hook 'paredit-mode)
  )

(defun byy-scheme/post-init-geiser ()
  ;; .sls files
  (use-package scheme-mode
    :mode "\\.sls\\'")

  ;; set geiser configs
  (setq geiser-active-implementations '(chez racket)
        geiser-chez-binary "chez")

  ;; when system is mac
  (when (spacemacs/system-is-mac)
    ;; set environment config
    (setenv "CHEZSCHEMELIBDIRS" "~/src/scheme-space:~/src/scheme/thunderchez"))
  )


;;; packages.el ends here

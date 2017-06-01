;;; packages.el --- byy/byy layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
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
;; added to `byy-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `byy/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `byy/pre-init-PACKAGE' and/or
;;   `byy/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst byy-packages
  '(company))

(defun byy/post-init-company ()
  (progn
    (setq company-minimum-prefix-length 2
          company-idle-delay 0.1)
    ;; (when (configuration-layer/package-usedp 'company)
    ;;   (spacemacs|add-company-hook json-mode))
    ))

;;; packages.el ends here

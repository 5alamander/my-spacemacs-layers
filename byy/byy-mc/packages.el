;;; packages.el --- byy/byy-mc layer packages file for Spacemacs.
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
;; added to `byy-mc-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `byy-mc/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `byy-mc/pre-init-PACKAGE' and/or
;;   `byy-mc/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst byy-mc-packages
  '(evil-mc))

(defun byy-mc/post-init-evil-mc ()
  (add-hook 'prog-mode-hook 'evil-mc-mode)
  (add-hook 'text-mode-hook 'evil-mc-mode)
  ;; evil-mc command

  ;; TODO
  ;; spacemacs|define-transient-state
  (spacemacs|define-micro-state byy-mc/evil-mc-add-cursor
    :doc
    "`n' make-and-go-to-next-match `t' skip-and-go-to-next-match"
    :use-minibuffer t
    :on-enter (evil-mc-make-and-goto-next-match)
    :bindings
    ("n" evil-mc-make-and-goto-next-match)
    ("t" evil-mc-skip-and-goto-next-match))
  )


;;; packages.el ends here

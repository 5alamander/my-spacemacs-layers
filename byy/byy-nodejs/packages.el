;;; packages.el --- byy/byy-nodejs layer packages file for Spacemacs.
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
;; added to `byy/byy-nodejs-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `byy/byy-nodejs/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `byy/byy-nodejs/pre-init-PACKAGE' and/or
;;   `byy/byy-nodejs/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst byy-nodejs-packages
  '(nodejs-repl
    gulp-task-runner))

(defun byy-nodejs/init-nodejs-repl ()
  (use-package nodejs-repl
    :init
    :defer t))

(defun byy-nodejs/post-init-nodejs-repl ()
  (use-package nodejs-repl
    :init
    (spacemacs/declare-prefix-for-mode 'js2-mode "msn" "Node REPL")
    (spacemacs/set-leader-keys-for-major-mode 'js2-mode
      "sni" 'nodejs-repl
      "snb" 'nodejs-repl-send-buffer
      "sne" 'nodejs-repl-send-last-sexp)
    :defer t))

;;; just load this package
(defun byy-nodejs/init-gulp-task-runner ()
  (use-package gulp-task-runner
    :init
    :defer t))

;;; packages.el ends here

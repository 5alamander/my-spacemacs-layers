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
  '(nodejs-repl)
  "The list of Lisp packages required by the byy/byy-nodejs layer.

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
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun byy-nodejs/init-nodejs-repl ()
  (use-package nodejs-repl
    :init
    :defer t))

(defun byy-nodejs/post-init-nodejs-repl ()
  (use-package nodejs-repl
    :init
    (spacemacs/declare-prefix-for-mode 'js2-mode "ms" "REPL")
    (spacemacs/set-leader-keys-for-major-mode 'js2-mode
      "si" 'nodejs-repl
      "sb" 'nodejs-repl-send-buffer
      "se" 'nodejs-repl-send-last-sexp)
    :defer t))

;;; packages.el ends here

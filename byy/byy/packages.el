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
  '(company evil rainbow-delimiters))

(defun byy/post-init-company ()
  ;; (global-company-mode)
  (setq company-minimum-prefix-length 2
        company-idle-delay 0.1)
  )

(defun byy/post-init-evil ()
  ;; evil ace
  (evil-leader/set-key "SPC" 'evil-avy-goto-word-or-subword-1)
  (evil-leader/set-key "y" 'evil-avy-goto-line)

  ;; set evil key-binding
  ;; (define-key evil-emacs-state-map (kbd "C-w") 'sa1-cut-line-or-region)
  ;; (define-key evil-hybrid-state-map (kbd "C-w") 'sa1-cut-line-or-region)
  ;; just as the OSX
  ;; (define-key evil-normal-state-map (kbd "M-w") 'kill-buffer-and-window)
  (define-key evil-normal-state-map (kbd "C-s") 'save-buffer)

  )

;;; rainbow colors
(defun byy/post-init-rainbow-delimiters ()
  (custom-set-faces
   '(rainbow-delimiters-depth-1-face ((t (:foreground "green"))))
   '(rainbow-delimiters-depth-2-face ((t (:foreground "green yellow"))))
   '(rainbow-delimiters-depth-3-face ((t (:foreground "yellow"))))
   '(rainbow-delimiters-depth-4-face ((t (:foreground "orange"))))
   '(rainbow-delimiters-depth-5-face ((t (:foreground "orange red"))))
   '(rainbow-delimiters-depth-6-face ((t (:foreground "magenta"))))
   '(rainbow-delimiters-depth-7-face ((t (:foreground "deep sky blue"))))
   '(rainbow-delimiters-depth-8-face ((t (:foreground "wheat"))))
   '(rainbow-delimiters-depth-9-face ((t (:foreground "wheat")))))
  )

;;; packages.el ends here

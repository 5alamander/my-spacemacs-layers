(message "my-log:: sa1-funcs.el")

;;; temp use yasnippet template
(defun sa1-yasnippet-string-to-template (string)
  (let ((count 1))
    (labels ((rep (text)
                  (let ((replace (format "${%d:%s}" count text)))
                    (incf count) replace)))
      (replace-regexp-in-string "[a-zA-Z0-9]+" #'rep string))))

;;; use current line to create a template
(defun sa1-yasnippet-current-line ()
  (interactive)
  (let ((current-line (string-trim-right (thing-at-point 'line t))))
    (end-of-line)
    (newline-and-indent)
    (yas-expand-snippet (sa1-yasnippet-string-to-template (string-trim current-line)))))

;;; window function, find window in direction and run functor
(defun sa1-window-find-and-run (dir arg window functor)
  "get and confirm the window at direction is interactive,
the run input `labda' (functor window other-window)"
  (let ((other-window (windmove-find-other-window dir arg window)))
    (cond ((null other-window)
           (error "No window %s from selected window" dir))
          ((and (window-minibuffer-p other-window)
                (not (minibuffer-window-active-p other-window)))
           (error "Minibuffer is inactive"))
          (t (funcall functor window other-window)))))

(defun sa1-open-buffer-path (choice)
  "Run explorer on the directory of this buffer."
  (interactive "cOpen directory (I) in, (O) out")
  (let* ((name (if (eq major-mode 'dired-mode)
                   (dired-get-filename)
                 (or (buffer-file-name) "")))
         (file-name (replace-regexp-in-string
                     "/" "\\" name t t))
         (directory (replace-regexp-in-string
                     "/" "\\" (file-name-directory name) t t)))
    (shell-command
     (concat "explorer /select, "
             (cond ((eq choice ?i) file-name)
                   ((eq choice ?o) directory))))))

(defun sa1-open-buffer-path-osx (choice)
  "Run explorer on the directory of this buffer. [OSX]"
  (interactive "cOpen directory (I) in, (O) out")
  (let* ((file-name (if (eq major-mode 'dired-mode)
                        (dired-get-filename)
                      (or (buffer-file-name) "")))
         (directory (file-name-directory file-name)))
    (shell-command
     (concat "open -R \""
             (cond ((eq choice ?i) file-name)
                   ((eq choice ?o) directory)) "\""))))

(defun sa1-open-directory-shell ()
  (interactive)
  (let* ((file-name (if (eq major-mode 'dired-mode)
                        (dired-get-filename)
                      (or (buffer-file-name) "")))
         (directory (file-name-directory file-name)))
    (shell-command (concat "open -a terminal \"" directory "\""))))

;;; set to "fy", replace the "spacemacs/show-and-copy-buffer-filename"
(defun sa1-copy-buffer-name (choice)
  "Copy the buffer-file-name to the kill-ring"
  (interactive "cCopy Buffer Name (F) Full, (D) Directory, (N) Name")
  (let ((new-kill-string)
        (name (if (eq major-mode 'dired-mode)
                  (dired-get-filename)
                (or (buffer-file-name) ""))))
    (cond ((eq choice ?f)
           (setq new-kill-string name))
          ((eq choice ?d)
           (setq new-kill-string (file-name-directory name)))
          ((eq choice ?n)
           (setq new-kill-string (file-name-nondirectory name)))
          (t (message "Quit")))
    (when new-kill-string
      (message "%s copied" new-kill-string)
      (kill-new new-kill-string))))

(defun sa1-es-search (input)
  "This method need `everything' installed, and add `es' to the path"
  (interactive "sSearch:")
  (shell-command (concat "es " input) "*es search result*")
  (pop-to-buffer "*es search result*"))

;;; change suffixMap to config value, TODO
(defun sa1-run-current-file ()
  "Execute or compile the current file.
For example, if the current buffer is the file x.pl,
then it'll call 'perl x.pl' in a shell.
The file can be php, perl, python, ruby, javascript, bash, ocaml, vb, elisp.
File suffix is used to determine what program to run.
If the file is modified, ask if you want to save first.
If the file is emacs lisp, run the byte compiled version if exist."
  (interactive)
  (let (suffixMap fName fSuffix progName cmdStr)
    ;; a keyed list of file suffix to command-line program path/name
    (setq suffixMap
          '(("php" . "php")
            ("coffee" . "coffee")
            ("pl" . "perl")
            ("py" . "python")
            ("rb" . "ruby")
            ("js" . "node")
            ("sh" . "bash")
            ("ml" . "ocaml")))
    (setq fName (buffer-file-name))
    (setq fSuffix (file-name-extension fName))
    (setq progName (cdr (assoc fSuffix suffixMap)))
    (setq cmdStr (concat progName " \"" fName "\""))
    (when (buffer-modified-p)
      (progn
        (when (y-or-n-p "Buffer modified. Do you want to save first?")
          (save-buffer))))
    (if (string-equal fSuffix "el")
        (progn
          (load (file-name-sans-extension fName)))
      (if progName
          (progn
            (message "Running %s ..." fName)
            (shell-command cmdStr "*run-current-file output*")) ; pop-to-buffer ?
        (message "No recognized program file suffix for this file.")))))

;;; copy line
(defun sa1-copy-line-or-region ()
  (interactive)
  (if mark-active
      (kill-ring-save (region-beginning) (region-end))
    (progn
      (kill-ring-save (line-beginning-position) (line-end-position))
      (message "copy line"))))

(global-set-key (kbd "M-w") 'sa1-copy-line-or-region)

;;; cut line
(defun sa1-cut-line-or-region ()
  (interactive)
  (if mark-active
      (kill-region (region-beginning) (region-end))
    (progn
      (kill-region (line-beginning-position) (line-end-position))
      (message "cut line"))))

;;; move to init function
;; (define-key evil-emacs-state-map (kbd "C-w") 'sa1-cut-line-or-region)
;; (define-key evil-hybrid-state-map (kbd "C-w") 'sa1-cut-line-or-region)

;;; replace the default buffer name, TODO, move to keybindings file
(evil-leader/set-key "fy" 'sa1-copy-buffer-name)

(defun sa1-org-show-all-inline-images ()
  (interactive)
  (org-display-inline-images t t))

(defun sa1-dos2unix ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(setq byy-org-packages '(org))

(defun byy-org/init-org ()
  "Initialize org mode"
  (use-package org
    :config
    (setq-default

     org-todo-keywords
     '((sequence "TODO(t)" "|" "DONE(D)")
       (type "SIMPLE(s)" "FAST-TRACK(F)" "CONFLICTING(c)" "WAITING(w)" "DUBIOUS(d)"
             "|" "MERGED(M)" "CLOSED(c)"))

     org-todo-keyword-faces
     '(("SIMPLE" . "khaki2")
       ("FAST-TRACK" . "OrangeRed1")
       ("WAITING" . "deepskyblue1"))

     org-src-fontify-natively t
     org-default-notes-file "~/org/notes.org"

     org-capture-templates
     '(("t" "Todo [region]" entry
        (file+headline (concat org-directory "/gtd.org") "Task")
        "* TODO %?\n %i\n" :empty-lines 1)
       ("i" "Inspire [region, file-link]" entry
        (file+headline (concat org-directory "/inspiration.org") "Inspire")
        "* %?\n %i\n %a %f" :empty-lines 1)
       ("n" "Notes")
       ("ng" "Note General" entry
        (file+headline (concat org-directory "/note.org") "Note")
        "* %?\n%i\n%U" :empty-lines 1)
       ("nt" "Note [region & time]" entry
        (file+headline (concat org-directory "/note.org") "Note")
        "* %?\n %i\n" :empty-lines 1)
       ("l" "Link [clipboard]" plain (file (concat org-directory "/links.org"))
        "- %?\n %x\n" :empty-lines 1))
     )

    (global-set-key (kbd "C-c c") 'org-capture))

  )

;;; packages.el ends here

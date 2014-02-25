(defun init-mallen ()
  "initialise the mark allen project"
  (interactive)
  (message "Initialising Mark Allen Project")
  (cd "~/work/mallen/allen-legal")
  (nrepl-jack-in))

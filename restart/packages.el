;;; packages.el --- restart layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Joshua Lindsey <joshua.s.lindsey@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst restart-packages
  '(restart-emacs))

(defun restart/init-restart-emacs ()
  (use-package restart-emacs
    :defer t
    :init
    (defun spacemacs/restart-emacs (&optional args)
      "Restart emacs."
      (interactive)
      (setq spacemacs-really-kill-emacs t)
      (restart-emacs args))
    (defun spacemacs/restart-emacs-resume-layouts (&optional args)
      "Restart emacs and resume layouts."
      (interactive)
      (spacemacs/restart-emacs (cons "--resume-layouts" args)))
    (defun spacemacs/restart-emacs-debug-init (&optional args)
      "Restart emacs and enable debug-init."
      (interactive)
      (spacemacs/restart-emacs (cons "--debug-init" args)))
    (defun spacemacs/restart-stock-emacs-with-packages (packages &optional args)
      "Restart emacs without the spacemacs configuration, enable
debug-init and load the given list of packages."
      (interactive
       (progn
         (unless package--initialized
           (package-initialize t))
         (let ((packages (append (mapcar 'car package-alist)
                                 (mapcar 'car package-archive-contents)
                                 (mapcar 'car package--builtins))))
           (setq packages (mapcar 'symbol-name packages))
           (let ((val (completing-read-multiple "Packages to load (comma separated): "
                                                packages nil t)))
             `(,val)))))
      (let ((load-packages-string (mapconcat (lambda (pkg) (format "(use-package %s)" pkg))
                                             packages " ")))
        (spacemacs/restart-emacs-debug-init
         (append (list "-q" "--execute"
                       (concat "(progn (package-initialize) "
                               "(require 'use-package)"
                               load-packages-string ")"))
                 args))))
    (spacemacs/set-leader-keys
      "qd" 'spacemacs/restart-emacs-debug-init
      "qD" 'spacemacs/restart-stock-emacs-with-packages
      "qr" 'spacemacs/restart-emacs-resume-layouts
      "qR" 'spacemacs/restart-emacs)))

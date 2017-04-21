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

(defconst win-numbering-packages
  '(window-numbering))

(defun win-numbering/init-window-numbering ()
  (use-package window-numbering
    :config
    (progn
      (when (configuration-layer/package-usedp 'spaceline)
        (defun window-numbering-install-mode-line (&optional position)
          "Do nothing, the display is handled by the powerline."))
      (setq window-numbering-auto-assign-0-to-minibuffer nil)
      (spacemacs/set-leader-keys
        "0" 'select-window-0
        "1" 'select-window-1
        "2" 'select-window-2
        "3" 'select-window-3
        "4" 'select-window-4
        "5" 'select-window-5
        "6" 'select-window-6
        "7" 'select-window-7
        "8" 'select-window-8
        "9" 'select-window-9)
      (window-numbering-mode 1))

    ;; make sure neotree is always 0
    (defun spacemacs//window-numbering-assign ()
      "Custom number assignment for neotree."
      (when (and (boundp 'neo-buffer-name)
                 (string= (buffer-name) neo-buffer-name)
                 ;; in case there are two neotree windows. Example: when
                 ;; invoking a transient state from neotree window, the new
                 ;; window will show neotree briefly before displaying the TS,
                 ;; causing an error message. the error is eliminated by
                 ;; assigning 0 only to the top-left window
                 (eq (selected-window) (window-at 0 0)))
        0))

    ;; using lambda to work-around a bug in window-numbering, see
    ;; https://github.com/nschum/window-numbering.el/issues/10
    (setq window-numbering-assign-func
          (lambda () (spacemacs//window-numbering-assign)))))

;;; packages.el --- dired-plus layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Joshua Lindsey <joshua.s.lindsey@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst dired-plus-packages
  '(dired+))

(defun dired-plus/init-dired+ ()
  (use-package dired+
    :init
    (diredp-toggle-find-file-reuse-dir 1)))

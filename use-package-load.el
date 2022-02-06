;;; use-package-load.el --- load keyword for use-package  -*- lexical-binding: t; -*-

;; Copyright (C) 2022 Xavier Capaldi

;; Author: Xavier Capaldi <xcapaldi@scribo.biz>
;; Keywords: convenience, tools, extensions
;; URL: https://github.com/xcapaldi/use-package-load
;; Version: 0.1
;; Package-Requires ((use-package "2.1"))
;; Filename: use-package-load.el
;; License: GNU General Public License version 3, or (at your option) any later version
;;

;;; Commentary:
;;
;; The `:load' keyword allows you to pass the path to an elisp
;; file containing arbitrary code in a similar manner as the
;; `:load-path` keyword.
;;

;;; Code:

(require 'use-package)

;;;###autoload
(defun use-package-normalize/:load (_name keyword args)
  (use-package-as-one (symbol-name keyword) args
    #'use-package-normalize-paths))

;;;###autoload
(defun use-package-handler/:load (name _keyword arg rest state)
  (let ((body (use-package-process-keywords name rest state)))
    (use-package-concat
     (mapcar #'(lambda (path)
                 `(eval-and-compile (load ,path)))
             arg)
     body)))

(add-to-list 'use-package-keywords :load t)

(provide 'use-package-load)

;;; use-package-load.el ends here

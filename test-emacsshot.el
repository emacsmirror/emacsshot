;;; test-emacsshot.el --- testing -*- lexical-binding: t -*-
;; #+STARTUP: oddeven

;;; Header:

;; Copyright 2014-2016 Marco Wahl

;; Author: Marco Wahl <marcowahlsoft@gmail.com>
;; Maintainer: Marco Wahl
;; Version: 0.3
;; Created: 2014-01-26
;; Keywords: convenience
;; URL: https://github.com/marcowahl/emacsshot

;; This file is not part of Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(require 'emacsshot)

;;; Code:


(ert-deftest test-emacsshot-enhance-filename-with-timestamp-1 ()
  (should
   (string-equal
    "bar"
    (file-name-extension (emacsshot-enhance-filename-with-timestamp "foo.bar")))))

(ert-deftest test-emacsshot-enhance-filename-with-timestamp-2 ()
    (should
     (= (length "foo-20160822121936.bar")
        (length (emacsshot-enhance-filename-with-timestamp "foo.bar")))))


(ert-deftest test-emacsshot-snap-filename-1 ()
  (should (string-equal "frame.png" (emacsshot-build-filename "frame.png"))))

(ert-deftest test-emacsshot-snap-filename-2 ()
  (should (< (length "frame.png") (length (emacsshot-build-filename "frame.png" t)))))


;;; Tail:

;; # Local Variables:
;; # lentic-init: lentic-orgel-org-init
;; # End:

;;; test-emacsshot.el ends here

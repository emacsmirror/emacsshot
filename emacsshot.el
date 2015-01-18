;;; emacsshot.el --- Snapshot a frame or window from within Emacs

;;; Header:

;; Copyright 2014-2015 Marco Wahl
;;  
;; Author: Marco Wahl <marcowahlsoft@gmail.com>
;; Maintainer: Marco Wahl
;; Version: 0.2
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

;;; Commentary:

;; ** What emacsshot is

;; Program emacsshot provides two functions to take a snapshot of Emacs.

;; ** Usage

;; M-x emacsshot-snap-frame creates file '~/emacsshot.png' which is a
;; snapshot of the current Emacs-frame.

;; M-x emacsshot-snap-window creates file '~/emacsshot.png' which is a
;; snapshot of the current Emacs-window.

;; The filename is configurable.  Hint: M-x customize-group emacsshot.

;; It might be a good idea to set function emacsshot-snap-frame to a key
;; in order to avoid images which contain the string "M-x
;; emacsshot-snap-frame" in the mode-line.  (Heisenshot?)

;; The print-key could trigger the shot.  E.g.

;; (global-set-key (kbd "<print>") 'emacsshot-snap-frame)

;; Or evaluate

;; (global-set-key (kbd "<print>")
;;  (lambda (&optional current-window)
;;   (interactive "P")
;;   (if current-window (emacsshot-snap-window)
;;     (emacsshot-snap-frame))))

;; to snap the frame and the current window by using the prefix
;; argument C-u.

;; ** Activation

;; *** Emacs Package

;; When emacsshot has been installed as elpa-package then the
;; functionality is available without need of further action.

;; *** More direct

;; Activate this program by loading it into Emacs and evaluate it with
;;  
;; M-x eval-buffer
;;  
;; Automatically activate this program at Emacs start by adding the lines
;;  
;; (add-to-list 'load-path "/...path to this program...")
;; (require 'emacsshot)

;; to your .emacs or whatever you use for Emacs intitialization.

;; ** Dependencies

;; 1. Emacs is running under X.

;; 2. The program 'convert' of the ImageMagick-suite is available.
;; 'convert' is the program that actually creates the snapshots.

;; ** Hints

;; There is elpa-package 'screenshot' which allows to pick windows
;; with the mouse, even windows from non-Emacs (!) programs.
;; BTW 'screenshot' has even more!

;; emacsshot only takes images of Emacs.

;;; History:

;; 201501071941 New function to take snapshot of a window.

;;; Code:

;; ** Configuration

;; #+BEGIN_SRC emacs-lisp
(defcustom emacsshot-snap-frame-filename "~/emacsshot.png"
  "Filename under which to store the next frame-snap."
  :group 'emacsshot)

(defcustom emacsshot-snap-window-filename "~/emacsshot.png"
  "Filename under which to store the next window-snap."
  :group 'emacsshot)
;; #+END_SRC

;; ** Snapshot Functions

;; #+BEGIN_SRC emacs-lisp
;;;###autoload
(defun emacsshot-snap-frame ()
  "Save an image of the current Emacs-frame.

The image is stored with the name defined in
`emacsshot-snap-frame-filename'.  There is no check against
overriding."
  (interactive)
  (let ((filename
         (expand-file-name
          emacsshot-snap-frame-filename)))
    (call-process
     "convert"
     nil (get-buffer-create "*convert-output*") nil
     (format
      "x:%s"
      (frame-parameter nil 'outer-window-id))
     filename)
    (message (concat "Written file " filename))))

;;;###autoload
(defun emacsshot-snap-window ()
  "Save an image of the current window.

The image is stored with the name defined in
`emacsshot-snap-window-filename'.  There is no check against
overriding."
  (interactive)
  (let ((filename
         (expand-file-name
          emacsshot-snap-window-filename)))
    (call-process
     "convert"
     nil (get-buffer-create "*convert-output*") nil
     (format
      "x:%s[%dx%d+%d+%d]"
      (frame-parameter nil 'window-id)
      (window-pixel-width)
      (window-pixel-height)
      (nth 0 (window-pixel-edges))
      (nth 1 (window-pixel-edges)))
     filename)
    (message (concat "Written file " filename))))

(provide 'emacsshot)

;;; emacsshot.el ends here
;; #+END_SRC

;; # Local Variables:
;; # lentic-init: lentic-orgel-org-init
;; # End:

;;; emacsshot.el -- Take an image of a frame or window from within emacs

;; Copyright 2014-2015 Marco Wahl


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


;; Author: Marco Wahl <marcowahlsoft@gmail.com>
;; Maintainer: Marco Wahl
;; Version: 0.2
;; Created: 2014-01-26
;; Keywords: screenshot, convenience


;;; Commentary:

;; Activation:
;;
;; Activate this program by loading it into Emacs and evaluate it with
;;
;; M-x eval-buffer
;;
;; Optional: Automatically activate this program by adding the lines
;;
;; (add-to-list 'load-path "/...path to this program...")
;; (require 'emacsshot)
;;
;; to your emacs-configuration-file.
;;
;; Optional: Set a filename for the snapshot-image.  This is the value
;; of variable `eshot-snap-frame-filename'.  You can customize it via
;;
;; M-x customize-variable
;;
;; 
;; Action:
;; 
;; Create a snapshot of the current Emacs-frame with
;;
;; M-x eshot-snap-frame
;; 
;; Create a snapshot of the current Emacs-window with
;;
;; M-x eshot-snap-window
;;
;; It might be a good idea to set the functions to a key in order to
;; avoid images which contain the string "M-x eshot-snap-frame" in the
;; mode-line.  Heisenshot?  E.g. the print-key could trigger the shot
;;
;; M-x eval-expression (global-set-key (kbd "<print>") 'eshot-snap-frame)
;;
;;
;; Precondition:
;;
;; 1. Emacs is running under X.
;;
;; 2. The program 'convert' of the ImageMagic-suite is available.
;; 'convert' is the program that actually creates the snapshots.
;;
;;
;; Hints:
;;
;; There is elpa-package screenshot which allows to pick a window to
;; be shot with the mouse.
;;

;;; Change Log:
;; 201501071941 New function to take snapshot of a window.

;;; Code:

(defcustom eshot-snap-frame-filename "~/emacsshot.png"
  "Filename under which to store the next frame-snap.")

(defcustom eshot-snap-window-filename "~/emacsshot.png"
  "Filename under which to store the next window-snap.")


(defun eshot-snap-frame ()
  "Save an image of the current Emacs-frame.

The image is stored with the name defined in
`eshot-snap-frame-filename'.  There is no check against
overriding."
  (interactive)
  (call-process
   "convert"
   nil (get-buffer-create "*convert-output*") nil
   (format "x:%s" (frame-parameter nil 'outer-window-id))
   (expand-file-name eshot-snap-frame-filename))
  (message
   (concat
    "Written file "
    (expand-file-name eshot-snap-frame-filename))))


(defun eshot-snap-window ()
  (interactive)
  (let ((filename
         (expand-file-name
          eshot-snap-window-filename)))
    (call-process
     "convert"
     nil (get-buffer-create "*convert-output*") nil
     (format
      "x:%s[%dx%d+%d+%d]"
      (frame-parameter nil 'window-id)
      (window-pixel-width)
      (window-pixel-height)
      (nth 0 (window-inside-pixel-edges))
      (nth 1 (window-inside-pixel-edges)))
     filename)
    (message
     (concat
      "Written file " filename))))


(provide 'emacsshot)

;;; emacsshot.el ends here

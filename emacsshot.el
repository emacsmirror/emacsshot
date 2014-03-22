;; emacsshot.el -- Snapshot an Emacs-frame from within emacs.
;; Copyright 2014 Marco Wahl
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;; Version: 0.0
;; Created: 2014-01-26
;; Contact: marcowahlsoft()gmail.com
;;
;;
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
;; to your emacs-configuration-file, typically called '.emacs'.
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
;; It might be a good idea to activate the function by a key.
;; You could define the print key to trigger the function-call with
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


(defcustom eshot-snap-frame-filename "~/emacsshot.png"
  "Filename under which to store the next frame-snap.")


(defun eshot-snap-frame ()
  "Save an image of the current Emacs-frame.

The image is stored with the name defined in
`eshot-snap-frame-filename'.  There is no check against
overriding.

The window-decoration due to the window-manager gets not
snapped."
  (interactive)
  (call-process
   "convert" nil (get-buffer-create "*convert-output*") nil
   (format "x:%s" (frame-parameter nil 'outer-window-id))
   (expand-file-name eshot-snap-frame-filename)))


(provide 'emacsshot)

;; emacsshot.el ends here.

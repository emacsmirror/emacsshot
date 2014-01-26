;; emacsshot.el -- Snapshot an Emacs-moment from within emacs.
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

;; Activation:
;;
;; M-x eval-buffer
;;
;; Optional: Set a filename for the snapshot-image.  This is the value
;; of variable `eshot-snap-frame-filename'.
;;
;; 
;; Action:
;; 
;; Create a snapshot of the current Emacs-frame with
;;
;; M-x eshot-snap-frame


(defcustom eshot-snap-frame-filename "~/emacs-frame-snap.png"
  "Filename under which to store the next frame-snap.")


(defun eshot-snap-frame ()
  "Save an image of the current frame.

The image is stored with the name defined in
`eshot-snap-frame-filename'.  No check is done against overriding."
  (interactive)
  (let ((window-id (frame-parameter nil 'outer-window-id)))
        (call-process
	 "convert" nil (get-buffer-create "*convert-output*") nil
	 (format "x:%s" window-id)
	 (expand-file-name eshot-snap-frame-filename))))


(provide 'emacsshot)

;; emacsshot.el ends here.

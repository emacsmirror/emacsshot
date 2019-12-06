;;; emacsshot.el --- Snapshot a frame or window from within -*- lexical-binding: t -*-
;; #+STARTUP: oddeven

;;; Header:

;; Copyright 2014-2019 Marco Wahl

;; Author: Marco Wahl <marcowahlsoft@gmail.com>
;; Maintainer: Marco Wahl
;; Created: 2014-01-26
;; Version: 0.5.0
;; Keywords: convenience
;; URL: https://github.com/marcowahl/emacsshot
;; Package-Requires: ((emacs "24.4"))

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

;;; Meta:

;; Create documentation by switching to the lentic Org view followed by
;; export of subtree [[id:7351e8d6-758c-4561-a938-1f9912f19f69][Documentation]].

;;; Documentation:
;;   :PROPERTIES:
;;   :ID:       7351e8d6-758c-4561-a938-1f9912f19f69
;;   :END:

;; ** What

;; =emacsshot= provides a few commands to take a screenshot of
;; Emacs from within Emacs.

;; [[./emacsshot.png]]

;; ** Usage

;; *** Quick

;; With =emacsshot= there are

;; - =M-x emacsshot-snap-frame=
;; - =M-x emacsshot-snap-window=
;; - =M-x emacsshot-snap-window-include-modeline=
;; - =M-x emacsshot-snap-mouse-drag=

;; for creating a shot of Emacs.

;; *** Hints and Detais

;; With the default settings =M-x emacsshot-snap-frame= creates file
;; '~/emacsshot.png' which is a snapshot of the current Emacs-frame
;; with all its windows.

;; There is also =M-x emacsshot-snap-window= which is for creating a
;; snapshot of the current Emacs-window (i.e. the window which contains
;; the active cursor.)

;; There is function =emacsshot-snap-window-include-modeline=
;; which does the same as =emacsshot-snap-window= but also includes the
;; modeline when taking the shot.

;; There is function =emacsshot-snap-mouse-drag= which snaps the
;; rectangle defined by a drag i.e. press button-1, keep pressed, move
;; the mouse and release the button.

;; The filenames are configurable.  Hint: =M-x customize-group
;; emacsshot=.  Note that the file-suffix defines the image-format
;; under which the file gets stored.  Note that the filenames may
;; contain paths which allows some organization of the shots.

;; It's possible to add a timestamp to the filename as postfix.  See
;; =M-x customize-variable emacsshot-with-timestamp=.

;; It might be a good idea to bind the functions to a key.  This can
;; make the usage more convenient.  Further the binding is a way to
;; avoid images which contain the command that has been used to create
;; the image e.g. "M-x emacsshot-snap-frame" in the minibuffer.

;; Beware of the heisenshot!

;; Concretely the print-key could trigger the shot.  Evaluation of

;; #+BEGIN_EXAMPLE
;; (global-set-key [print] 'emacsshot-snap-frame)
;; (global-set-key (kbd "C-M-S-<mouse-1>") 'emacsshot-snap-mouse-drag)

;; #+END_EXAMPLE

;; yields this behavior.

;; Or evaluate

;; #+BEGIN_EXAMPLE
;; (global-set-key [print]
;;  (lambda (&optional current-window)
;;   (interactive "P")
;;   (if current-window (emacsshot-snap-window)
;;     (emacsshot-snap-frame))))
;; #+END_EXAMPLE

;; to be able to snap the frame by pressing the print-key and to snap the
;; current window by prefixing the keypress with C-u.

;; Note that emacsshot currently trys to overwrite any existing file with
;; the target name without asking.

;; ** Install

;; *** Emacs Package

;; When emacsshot has been installed as elpa-package
;; [[http://melpa.org/#/emacsshot][file:http://melpa.org/packages/emacsshot-badge.svg]] then the functions
;; are available without need of further action.

;; *** Direct Install

;; Activate this program by loading it into Emacs and evaluate it with
;; =M-x eval-buffer=.

;; Automatically activate this program at Emacs start by adding the lines

;; #+BEGIN_EXAMPLE
;; (add-to-list 'load-path "/...path to this program...")
;; (require 'emacsshot)
;; #+END_EXAMPLE

;; to your .emacs or whatever you use for Emacs intitialization.

;; ** Dependencies

;; - Emacs is running under X.
;; - The programm =convert= of the ImageMagick-suite is available.

;; =convert= actually creates the snapshots.

;; ** Development

;; *** Lentic Literate Style

;; This program is written in Emacs Lisp in lentic style based on the
;; 'lentic' package [[http://melpa.org/#/lentic][file:http://melpa.org/packages/lentic-badge.svg]].

;; This means the that this file can be regarded just as an Emacs Lisp
;; file.  But actually this file contains extra comments which allow the
;; interpretation of the file as Org file.  Lentic-mode makes it easy to
;; write this style.

;; A possible initialization of lentic is this:

;; #+BEGIN_EXAMPLE
;; (global-lentic-start-mode)
;; #+END_EXAMPLE

;; Find more about lentic at
;; [[http://melpa.org/#/lentic][file:http://melpa.org/packages/lentic-badge.svg]].

;; *** Ideas, Contributions, Bugs

;; Contributions, ideas and bug-reports are welcome.

;; Please use the infrastructure of github for communication.  See
;; https://github.com/marcowahl/emacsshot/issues.

;; ** Related

;; There is elpa-package 'screenshot' which allows to pick windows
;; with the mouse, even windows from non-Emacs (!) programs.  See
;; http://melpa.org/#/screenshot.  BTW 'screenshot' has even more!

;; emacsshot only takes images of Emacs.

;; ** History

;; | 201501071941 | New function to take snapshot of a window |
;; | 201505162319 | Optionally add timestamp to save-filename |
;; | 201912060235 | New function to take snapshot of a rectangle defined by a mouse-drag |

;;; Code:

;; ** Configuration

;; #+BEGIN_SRC emacs-lisp
(defcustom emacsshot-snap-frame-filename "~/emacsshot.png"
  "Filename under which to store the next frame-snap.
The file-suffix defines the image-format under which the file
gets stored.  Note also that a timestamp may be added.  See
`emacsshot-with-timestamp'."
  :group 'emacsshot
  :type 'string)

(defcustom emacsshot-snap-window-filename "~/emacsshot.png"
  "Filename under which to store the next window-snap.
The file-suffix defines the image-format under which the file
gets stored.  Note also that a timestamp may be added.  See
`emacsshot-with-timestamp'."
  :group 'emacsshot
  :type 'string)

(defcustom emacsshot-snap-mouse-filename "~/mouseshot.png"
  "Filename under which to store the next mouse-snap.
The file-suffix defines the image-format under which the file
gets stored.  Note also that a timestamp may be added.  See
`emacsshot-with-timestamp'."
  :group 'emacsshot
  :type 'string)

(defcustom emacsshot-with-timestamp nil
  "When on, add current timestamp to the filename."
  :group 'emacsshot
  :type 'boolean)
;; #+END_SRC

;; ** Auxilliary Functions

;; #+BEGIN_SRC emacs-lisp
(defun emacsshot-enhance-filename-with-timestamp (filename)
  "Append a timestamp to the given FILENAME."
  (concat
   (or (file-name-sans-extension filename) "")
   "-"
   (format-time-string "%Y%m%d%H%M%S")
   (if (file-name-extension filename)
       (concat  "." (file-name-extension filename))
     "")))
;; #+END_SRC

;; #+BEGIN_SRC emacs-lisp
(defun emacsshot-build-filename (file-name &optional timestamp-p)
  (if timestamp-p
      (emacsshot-enhance-filename-with-timestamp file-name)
    file-name))
;; #+END_SRC

;; ** Snapshot Functions

;; #+BEGIN_SRC emacs-lisp
(defun emacsshot--snap-window-to-file-flipflop (filename)
  "Save an image of the current window rotated 180 degrees.

The image is stored with name FILENAME."
  (if (= 0 (call-process
            "convert"
            nil (get-buffer-create "*convert-output*") nil
            (format
             "x:%s[%dx%d+%d+%d]"
             (frame-parameter nil 'window-id)
             (window-pixel-width)
             (window-body-height nil t)
             (nth 0 (window-pixel-edges))
             (nth 1 (window-pixel-edges)))
            "-flip"
            "-flop"
            filename))
      (message (concat "Written file " filename))
    (error (concat "Could not create snapshot to file " filename))))

(defun emacsshot--snap-window-to-file (filename)
  "Save an image of the current window.

The image is stored with name FILENAME."
  (if (= 0 (call-process
            "convert"
            nil (get-buffer-create "*convert-output*") nil
            (format
             "x:%s[%dx%d+%d+%d]"
             (frame-parameter nil 'window-id)
             (window-pixel-width)
             (window-body-height nil t)
             (nth 0 (window-pixel-edges))
             (nth 1 (window-pixel-edges)))
            filename))
      (message (concat "Written file " filename))
    (error (concat "Could not create snapshot to file " filename))))

(defun emacsshot--snap-window (include-modeline)
  "Save an image of the current window.

  The image is stored with the name defined in
  `emacsshot-snap-window-filename'.  There is no check against
  overriding.
Argument INCLUDE-MODELINE t means to include, else exclude the modeline."
  (let ((filename
         (expand-file-name
          (emacsshot-build-filename
           emacsshot-snap-window-filename
           emacsshot-with-timestamp))))
    (if (= 0 (call-process
              "convert"
              nil (get-buffer-create "*convert-output*") nil
              (format
               "x:%s[%dx%d+%d+%d]"
               (frame-parameter nil 'window-id)
               (1- (window-pixel-width))
               (+ (window-body-height nil t)
                  (or (when include-modeline
                        (window-mode-line-height))
                      0))
               (+ 1 (nth 0 (window-pixel-edges)))
               (nth 1 (window-pixel-edges)))
              filename))
        (message (concat "Written file " filename))
      (error (concat "Could not write file " filename)))))
;; #+END_SRC

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
          (emacsshot-build-filename
           emacsshot-snap-frame-filename
           emacsshot-with-timestamp))))
    (if (= 0 (call-process
              "convert"
              nil (get-buffer-create "*convert-output*") nil
              (format
               "x:%s"
               (frame-parameter nil 'outer-window-id))
              filename))
        (message (concat "Written file " filename))
      (error (concat "Could not write file " filename)))))

;;;###autoload
(defun emacsshot-snap-window ()
  "Save an image of the current window (without modeline.)

The image is stored with the name defined in
`emacsshot-snap-window-filename'.  There is no check against
overriding."
  (interactive)
  (emacsshot--snap-window nil))

;;;###autoload
(defun emacsshot-snap-window-include-modeline ()
  "Save an image of the current window including the modeline.

The image is stored with the name defined in
`emacsshot-snap-window-filename'.  There is no check against
overriding."
  (interactive)
  (emacsshot--snap-window t))

;;;###autoload
(defun emacsshot-snap-mouse-drag ()
  "Save an image of a rectangle defined by a mouse-drag.
For a mouse-drag press button-1, keep pressed, move the mouse and
release.

The image is stored with the name defined in
`emacsshot-snap-mouse-filename'.  There is no check against
overriding."
  (interactive)
  (let ((drag-rectangle
         (let (done) ;; from docview-mode.
           (while (not done)
             (let ((e (read-event
	               (concat "Press mouse-1 and drag to the other corner."))))
               (when (eq (car e) 'drag-mouse-1)
                 (let ((x1 (car (posn-x-y (event-start e))))
                       (y1 (cdr (posn-x-y (event-start e))))
                       (x2 (car (posn-x-y (event-end e))))
                       (y2 (cdr (posn-x-y (event-end e)))))
                   (setq done
                         (list
                          (min x1 x2)
                          (min y1 y2)
                          (max x1 x2)
                          (max y1 y2)))))))
           done))
        (filename
         (expand-file-name
          (emacsshot-build-filename
           emacsshot-snap-mouse-filename
           emacsshot-with-timestamp))))
    (message "%s drag-rectangle." drag-rectangle)
    (if (= 0 (call-process
              "convert"
              nil (get-buffer-create "*convert-output*") nil
              (format
               "x:%s[%dx%d+%d+%d]"
               (frame-parameter nil 'window-id)
               (- (nth 2 drag-rectangle) (nth 0 drag-rectangle))
               (- (nth 3 drag-rectangle) (nth 1 drag-rectangle))
               (+ (1+ (nth 0 (window-pixel-edges))) (nth 0 drag-rectangle))
               (+ (nth 1 (window-pixel-edges)) (nth 1 drag-rectangle)))
              filename))
        (find-file filename)
      (error (concat "Could not write file " filename)))))

(provide 'emacsshot)
;; #+END_SRC

;;; Rest:

;; You can export section [[id:7351e8d6-758c-4561-a938-1f9912f19f69][Documentation]] to get documentation.  E.g. a
;; README.md suitable for github.


;; # Local Variables:
;; # lentic-init: lentic-orgel-org-init
;; # End:

;;; emacsshot.el ends here

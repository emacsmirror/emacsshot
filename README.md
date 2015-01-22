<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. What emacsshot is</a></li>
<li><a href="#sec-2">2. Usage</a></li>
<li><a href="#sec-3">3. Install</a>
<ul>
<li><a href="#sec-3-1">3.1. Emacs Package</a></li>
<li><a href="#sec-3-2">3.2. More direct</a></li>
</ul>
</li>
<li><a href="#sec-4">4. Dependencies</a></li>
<li><a href="#sec-5">5. Hints</a></li>
<li><a href="#sec-6">6. History</a></li>
</ul>
</div>
</div>

# What emacsshot is<a id="sec-1"></a>

Program emacsshot provides two functions to take a screenshot of Emacs
from within Emacs.

# Usage<a id="sec-2"></a>

`M-x emacsshot-snap-frame` creates file '~/emacsshot.png' which is a
snapshot of the current Emacs-frame.

`M-x emacsshot-snap-window` creates file '~/emacsshot.png' which is a
snapshot of the current Emacs-window.

The filenames are configurable.  Hint: `M-x customize-group emacsshot`.

It might be a good idea to bind the functions to a key.  This can make
the usage more convenient.  Further the binding is a way to avoid
images which contain the command that has been used to create the
image e.g. "M-x emacsshot-snap-frame" in the mode-line.  Beware of the
heisenshot!

Concretely the print-key could trigger the shot.  Evaluation of

    (global-set-key [print] 'emacsshot-snap-frame)

yields this behavior.

Or evaluate

    (global-set-key [print]
     (lambda (&optional current-window)
      (interactive "P")
      (if current-window (emacsshot-snap-window)
        (emacsshot-snap-frame))))

to be able to snap the frame by pressing the print-key and to snap the
current window by prefixing the keypress with C-u.

# Install<a id="sec-3"></a>

## Emacs Package<a id="sec-3-1"></a>

When emacsshot has been installed as elpa-package then the functions
are available without need of further action.

## More direct<a id="sec-3-2"></a>

Activate this program by loading it into Emacs and evaluate it with
`M-x eval-buffer`.

Automatically activate this program at Emacs start by adding the lines

    (add-to-list 'load-path "/...path to this program...")
    (require 'emacsshot)

to your .emacs or whatever you use for Emacs intitialization.

# Dependencies<a id="sec-4"></a>

1.  Emacs is running under X.

2.  The program 'convert' of the ImageMagick-suite is available.

'convert' is the program that actually creates the snapshots.

# Hints<a id="sec-5"></a>

There is elpa-package 'screenshot' which allows to pick windows
with the mouse, even windows from non-Emacs (!) programs.  See
<http://melpa.org/#/screenshot>.  BTW 'screenshot' has even more!

emacsshot only takes images of Emacs.

# History<a id="sec-6"></a>

201501071941 New function to take snapshot of a window.

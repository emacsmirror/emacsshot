<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org0c68ece">1. What</a></li>
<li><a href="#org4d50f36">2. Usage</a>
<ul>
<li><a href="#orgaad9855">2.1. Quick</a></li>
<li><a href="#org81dcd1b">2.2. Hints and Detais</a></li>
</ul>
</li>
<li><a href="#org99c49ab">3. Install</a>
<ul>
<li><a href="#org1a655a1">3.1. Emacs Package</a></li>
<li><a href="#org56068ef">3.2. Direct Install</a></li>
</ul>
</li>
<li><a href="#org7fd7fb7">4. Dependencies</a></li>
<li><a href="#org796733d">5. Development</a>
<ul>
<li><a href="#org7d3be3f">5.1. Lentic Literate Style</a></li>
<li><a href="#org5b602c5">5.2. Ideas, Contributions, Bugs</a></li>
</ul>
</li>
<li><a href="#org7cb048d">6. Related</a></li>
<li><a href="#org11f2620">7. History</a></li>
</ul>
</div>
</div>

# What<a id="org0c68ece"></a>

`emacsshot` provides a few commands to take a screenshot of
Emacs from within Emacs.

![img](./emacsshot.png)

# Usage<a id="org4d50f36"></a>

## Quick<a id="orgaad9855"></a>

With `emacsshot` there are

-   `M-x emacsshot-snap-frame`
-   `M-x emacsshot-snap-window`
-   `M-x emacsshot-snap-window-include-modeline`

for creating a shot of Emacs.

## Hints and Detais<a id="org81dcd1b"></a>

With the default settings `M-x emacsshot-snap-frame` creates file
'~/emacsshot.png' which is a snapshot of the current Emacs-frame
with all its windows.

There is also `M-x emacsshot-snap-window` which is for creating a
snapshot of the current Emacs-window (i.e. the window which contains
the active cursor.)

Further there is function `emacsshot-snap-window-include-modeline`
which does as `emacsshot-snap-window` but includes the modeline when
taking the shot.

The filenames are configurable.  Hint: `M-x customize-group emacsshot`.

It's even possible to add a timestamp to the filename as postfix.  See
`M-x customize-variable emacsshot-with-timestamp`.

It might be a good idea to bind the functions to a key.  This can
make the usage more convenient.  Further the binding is a way to
avoid images which contain the command that has been used to create
the image e.g. "M-x emacsshot-snap-frame" in the minibuffer.
Beware of the heisenshot!

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

Note that emacsshot currently trys to overwrite any existing file with
the target name without asking.

# Install<a id="org99c49ab"></a>

## Emacs Package<a id="org1a655a1"></a>

When emacsshot has been installed as elpa-package
[![img](http://melpa.org/packages/emacsshot-badge.svg)](http://melpa.org/#/emacsshot) then the functions
are available without need of further action.

## Direct Install<a id="org56068ef"></a>

Activate this program by loading it into Emacs and evaluate it with
`M-x eval-buffer`.

Automatically activate this program at Emacs start by adding the lines

    (add-to-list 'load-path "/...path to this program...")
    (require 'emacsshot)

to your .emacs or whatever you use for Emacs intitialization.

# Dependencies<a id="org7fd7fb7"></a>

-   Emacs is running under X.
-   The programm `convert` of the ImageMagick-suite is available.

`convert` actually creates the snapshots.

# Development<a id="org796733d"></a>

## Lentic Literate Style<a id="org7d3be3f"></a>

This program is written in Emacs Lisp in lentic style based on the
'lentic' package [![img](http://melpa.org/packages/lentic-badge.svg)](http://melpa.org/#/lentic).

This means the that this file can be regarded just as an Emacs Lisp
file.  But actually this file contains extra comments which allow the
interpretation of the file as Org file.  Lentic-mode makes it easy to
write this style.

A possible initialization of lentic is this:

    (global-lentic-start-mode)

Find more about lentic at
[![img](http://melpa.org/packages/lentic-badge.svg)](http://melpa.org/#/lentic).

## Ideas, Contributions, Bugs<a id="org5b602c5"></a>

Contributions, ideas and bug-reports are welcome.

Please use the infrastructure of github for communication.  See
<https://github.com/marcowahl/emacsshot/issues>.

# Related<a id="org7cb048d"></a>

There is elpa-package 'screenshot' which allows to pick windows
with the mouse, even windows from non-Emacs (!) programs.  See
<http://melpa.org/#/screenshot>.  BTW 'screenshot' has even more!

emacsshot only takes images of Emacs.

# History<a id="org11f2620"></a>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-right">201501071941</td>
<td class="org-left">New function to take snapshot of a window</td>
</tr>


<tr>
<td class="org-right">201505162319</td>
<td class="org-left">Optionally add timestamp to save-filename</td>
</tr>
</tbody>
</table>

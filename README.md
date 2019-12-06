<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#orgbbb162b">1. What</a></li>
<li><a href="#orga9357d2">2. Usage</a>
<ul>
<li><a href="#orge004ac4">2.1. Quick</a></li>
<li><a href="#org1dfb52b">2.2. Hints and Detais</a></li>
</ul>
</li>
<li><a href="#orge19412c">3. Install</a>
<ul>
<li><a href="#org8efe430">3.1. Emacs Package</a></li>
<li><a href="#org0416252">3.2. Direct Install</a></li>
</ul>
</li>
<li><a href="#org17f1ee5">4. Dependencies</a></li>
<li><a href="#orgd5fc0a8">5. Development</a>
<ul>
<li><a href="#org4e8e80c">5.1. Ideas, Contributions, Bugs</a></li>
</ul>
</li>
<li><a href="#org2fc1a5e">6. Related</a></li>
<li><a href="#org6e974ba">7. History</a></li>
</ul>
</div>
</div>

<a id="orgbbb162b"></a>

# What

`emacsshot` provides a few commands to take a screenshot of
Emacs from within Emacs.

![img](./emacsshot.png)


<a id="orga9357d2"></a>

# Usage


<a id="orge004ac4"></a>

## Quick

With `emacsshot` there are

-   `M-x emacsshot-snap-frame`
-   `M-x emacsshot-snap-window`
-   `M-x emacsshot-snap-window-include-modeline`
-   `M-x emacsshot-snap-mouse-drag`

for creating a shot of Emacs.


<a id="org1dfb52b"></a>

## Hints and Detais

With the default settings `M-x emacsshot-snap-frame` creates file
'~/emacsshot.png' which is a snapshot of the current Emacs-frame
with all its windows.

There is also `M-x emacsshot-snap-window` which is for creating a
snapshot of the current Emacs-window (i.e. the window which contains
the active cursor.)

Further there is function `emacsshot-snap-window-include-modeline`
which does the same as `emacsshot-snap-window` but also includes the
modeline when taking the shot.

There is function `emacsshot-snap-mouse-drag` which snaps the
rectangle defined by a drag i.e. press button-1, keep pressed, move
the mouse and release the button.

The filenames are configurable.  Hint: `M-x customize-group
emacsshot`.  Note that the file-suffix defines the image-format under
which the file gets stored.  Note that the filenames may
contain paths which allows some organization of the shots.

It's possible to add a timestamp to the filename as postfix.  See
`M-x customize-variable emacsshot-with-timestamp`.

It might be a good idea to bind the functions to a key.  This can
make the usage more convenient.  Further the binding is a way to
avoid images which contain the command that has been used to create
the image e.g. "M-x emacsshot-snap-frame" in the minibuffer.

Beware of the heisenshot!

Concretely the print-key could trigger the shot.  Evaluation of

    (global-set-key [print] 'emacsshot-snap-frame)
    (global-set-key (kbd "C-M-S-<mouse-1>") 'emacsshot-snap-mouse-drag)

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


<a id="orge19412c"></a>

# Install


<a id="org8efe430"></a>

## Emacs Package

When emacsshot has been installed as elpa-package
[![img](http://melpa.org/packages/emacsshot-badge.svg)](http://melpa.org/#/emacsshot) then the functions
are available without need of further action.


<a id="org0416252"></a>

## Direct Install

Activate this program by loading it into Emacs and evaluate it with
`M-x eval-buffer`.

Automatically activate this program at Emacs start by adding the lines

    (add-to-list 'load-path "/...path to this program...")
    (require 'emacsshot)

to your .emacs or whatever you use for Emacs intitialization.


<a id="org17f1ee5"></a>

# Dependencies

-   Emacs is running under X.
-   The programm `convert` of the ImageMagick-suite is available.

`convert` actually creates the snapshots.


<a id="orgd5fc0a8"></a>

# Development

<a id="org4e8e80c"></a>

## Ideas, Contributions, Bugs

Contributions, ideas and bug-reports are welcome.

<a id="org2fc1a5e"></a>

# Related

There is elpa-package 'screenshot' which allows to pick windows
with the mouse, even windows from non-Emacs (!) programs.  See
<http://melpa.org/#/screenshot>.  BTW 'screenshot' has even more!

emacsshot only takes images of Emacs.


<a id="org6e974ba"></a>

# History

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

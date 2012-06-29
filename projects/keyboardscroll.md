---
title: Keyboard Scroll
date: June 28, 2012
description: A jQuery plugin to scroll through websites with keypresses
---

Say you have webpage with multiple elements (eg. photos, divs) vertically
aligned. This plugin lets you press a key to scroll down (or up) the page until
the next (or previous) element is centered on the screen. 

This gives an alternative method for scrolling through a webpage while still
retaining the normal scrolling ability. It's useful because it a) makes it easy
to align the element properly to the screen and b) lets the user scroll with the
keyboard, which some find relaxing.

It's very similar to the j and k keys in [Google
Reader](www.google.com/reader), [Metafilter](www.metafilter.com), and [Boston
Globe's The Big Picture](http://www.boston.com/bigpicture/).

[Here's an example](../photography.html).


Download
--------
Uncompressed version: [jquery.keyboardScroll.js](../javascripts/jquery.keyboardScroll.js)  
Compressed version: [jquery.keyboardScroll.min.js](../javascripts/jquery.keyboardScroll.min.js)  
On Github: [https://github.com/victorgan/KeyboardScroll](https://github.com/victorgan/KeyboardScroll)

Quick Start
-----------

1. Save the [compressed file](../javascripts/jquery.keyboardScroll.min.js) to a
   folder within your website.

2. On each HTML page you wish to run KeyboardScroll, add the following to the head of
   the page. 

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"
        type="text/javascript"></script>
        <script src="/path/to/jquery.keyboardScroll.min.js"></script>
        <script type="text/javascript" charset="utf-8">
          $(function() {
                  $(".element").keyboardScroll();
          });
        </script>

3. Ensure your path to the `jquery.keyboardScroll.min.js` file is correct by
   replacing `/path/to` with the appropriate path.

4. Specify the elements you wish to scroll through by editing the
   `$(".element").keyboardScroll();` line. For example,
   `$("img.photo").keyboardScroll();` will scroll through all `img` tags with
   `class='photo'`, and  `$(".photo").keyboardScroll();` will scroll through all
   tags with `class='photo'`, regardless of the tag.

5. View your page. Pressing 'j' and 'k' should cycle through the elements.

Explanation
-----------
Let's go through the above code line by line. This plugin requires jQuery
version 1.7.2. This is done by including this:

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"
    type="text/javascript"></script>

The script containing the keyboardScroll function is inlcuded like so:

    <script src="/path/to/jquery.keyboardScroll.min.js"></script>

And finally, the function in `jquery.keyboardScroll.min.js` is called:

    <script type="text/javascript" charset="utf-8">
      $(function() {
              $(".element").keyboardScroll();
      });
    </script>

Customizations
--------------
KeyboardScroll has three optional parameters that can be set. This is done like
so:

    <script type="text/javascript" charset="utf-8">
      $(function() {
              $("element").keyboardScroll(
              {
                downKeyCode     : 74,   // 'j'
                upKeyCode       : 75,   // 'k'
                scrollDuration  : 100   // in milliseconds
              });
      });
    </script>

- `downKeyCode` specifies the key to press to scroll down an element. The default
  is j (key code 74)
- `upKeyCode` specifies the key to press to scroll up an element. The default is k
  (key code 75)
- `scrollDuration` specifies the time the scroll animation takes when scrolling.
  The default is 100 ms.

Licensing
---------
Feel free to use this for almost any purpose. Licensed under the [MIT license](http://www.opensource.org/licenses/mit-license.php).

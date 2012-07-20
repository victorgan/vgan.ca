---
title: vgan.ca
date: June 29, 2012
description: Making my personal site
---

I've recently launched this site; it's something I've been meaning to do for
a while now. Here I'll give a brief overview of the design choices and
impementation details for anyone who's interested in making a site similar to
this one.

Design Patterns: Lagom är bäst
------------------------------
In Swedish there is the word "Lagom". It has no direct English translation, but
it's an adjective that roughly means "just right" or "the perfect amount". I
tried to follow this line of thought to prevent overdesigning this site. This
meant trying for a site that looks crisp, but doesn't draw attention to itself
so the focus is kept on the content. 

There's a prevailing design trend led by Apple to make interfaces feel tactile
by imitating design cues of everyday objects.
[Skeuomorphism](http://www.fastcodesign.com/1669879/can-we-please-move-past-apples-silly-faux-real-uis),
as some people call it. I think it's cute, but for simple blog posts it feels
like overkill--two dimensions are more than enough for text. So I made a
compromise by using a textured background and having a single skeuomorph for the
home link to make the site feel comfortably modern but also retain its
minimalistic text-based roots.  

Not so for the photography pages though: I added a hint of depth to give the
photos a neat frame. I also used a light background for articles because it
feels less heavy on the eyes, but a dark background for the photo pages to make
the photos stand out more.

The width of the page is fixed as various pseudo-science[^usabilityclaims]
points to 66 characters per line as being optimal for reading, but moreso
because it makes the site seem less intimidating. Also to make sure the reader
knows exactly what to look at, at any given vertical position there's only one
piece of content. 

Introducing a colour into the site's foundation makes it hard to match so I
attempted to use as little as possible, except for the links which are a cool
shade of my favourite cerulean turquoise.

Typography
----------
Default sans-serif typefaces look good in small sizes but I don't like how they
look when they're above around 16px. For serif typefaces, I like the alternative
ligatures in italicised serifs. So I went with these. Keeping a vertical
[Rhythm](http://www.alistapart.com/articles/settingtypeontheweb/) is challenging
if you stray from the standard font sizes but I did anyway. At first I chose
font sizes that were multiples of each other, but then I realized some fonts
look best at specific sizes and that's more important than being
multiplicatively consistent. Demphasized tiny sans-serifs are sprinkled around
for contrast. 

Technologies
------------
I chose to use static HTML pages. Technically it's the simplest way to
distribute content. It's is a good idea for people who just want a simple blog
because of its inherent security, stability and fast loading pages. It's a bad
idea for people who rely on dynamic content or just want to get a blog up and
running without caring about the details.

There are some tools to make it easier so you don't have to write duplicate
HTML, among other things[^staticsite]. [Hakyll](http://jaspervdj.be/hakyll/) is
what I chose, although it's not exactly straightforward to fully grasp if you
don't know Haskell. This lets me write posts in text files in a format
called Markdown which is just a normal text file except you underline titles
with dashes and some other poor man's formatting.

I didn't use coffeescript or sass or any other css/html/javascript aides because
I can't justify another layer of complexity in a site as simple as this. 

### Hakyll Challenges
Hakyll's documentation is not comprehensive and it's somewhat tedious to
understand all it's parts at times, especially if you are also learning Haskell.

In the beginning states I found it easier to recompile the site with `runhaskell
hakyll.hs rebuild` as I would be modifying main haskell module quite often. This
is equivalent to

~~~
ghc --make hakyll.hs
./hakyll clean
./hakyll build
~~~

There's also some issues with the Hakyll compiler messing with double quotes in
embedded javascripts, but that can be stopped by using single quotes instead.

Hakyll claims to support syntax highlighting for code snippets out of the box.
However, you'll need to have a custom css file that uses the specific classes.
You can steal mine, which I took and modified from pandoc's site.

For all it's warts though, it's a very well-designed program.

### Navigating with the Keyboard

I wanted people to be able to scroll through the photos using the j and k keys.
I couldn't find anything that fit my needs, so I made my own [jQuery
plugin](/projects/keyboardscroll.html).

Conclusion
----------
I'm satisfied with the fine-grained comprehensive control I get from editing raw
HTML and CSS with Hakyll, as well as how the design turned out. An in-built
javascript minifier for Hakyll would be convenient but it's not that important.
Anyway, back to schoolwork.

[^usabilityclaims]: I'm weary of a lot of claims in the world of
usability. A lot of them sound like the pop psychology middle managers use to
help build team morale, or results from a study that's been generalized a bit
too far. I do buy into some, such as the [7-item working memory
limit](http://en.wikipedia.org/wiki/The_Magical_Number_Seven,_Plus_or_Minus_Two)
but they should be rules of thumb rather than steadfast commandments.  

[^staticsite]: These tools are called static site generators. There are some
evangelical promoters of static site generators, but to be fair a Tumblr or
Wordpress blog would require a lot less know-how to get set up and includes
features that are relatively hard to add with static site generators. The
big downside is you can't control absolutely everything.

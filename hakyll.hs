{-# LANGUAGE OverloadedStrings #-}
module Main where

import Prelude hiding (id)
import Control.Category (id)
import Control.Arrow ((>>>), (***), arr)
import Data.Monoid (mempty, mconcat)

import Hakyll

main :: IO ()
main = hakyll $ do

    -- Read templates
    match "templates/*" $ compile templateCompiler

    -- Copy assets
    match "assets/**" $ do
        route idRoute
        compile copyFileCompiler

    -- Copy javascript
    match "javascripts/*" $ do
        route idRoute
        compile copyFileCompiler

    -- Copy photos
    match "photos/*" $ do
        route idRoute
        compile copyFileCompiler

    -- Compress CSS
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    -- Render blog posts
    match "articles/*" $ do
        route   $ setExtension ".html"
        compile $ pageCompiler
            >>> arr (setField "colourscheme" "colourslight")
            >>> applyTemplateCompiler "templates/articlepage.html"
            >>> applyTemplateCompiler "templates/base.html"
            >>> relativizeUrlsCompiler

    -- Render project posts
    match "projects/*" $ do
        route   $ setExtension ".html"
        compile $ pageCompiler
            >>> arr (setField "colourscheme" "colourslight")
            >>> applyTemplateCompiler "templates/articlepage.html"
            >>> applyTemplateCompiler "templates/base.html"
            >>> relativizeUrlsCompiler

    -- Render project posts
    match "photography/*" $ do
        route   $ idRoute
        compile $ readPageCompiler
            >>> addDefaultFields
            >>> arr (setField "colourscheme" "coloursdark")
            >>> applyTemplateCompiler "templates/photography.html"
            >>> applyTemplateCompiler "templates/base.html"
            >>> relativizeUrlsCompiler

    -- Render /articles.html
    match  "articles.html" $ route idRoute
    create "articles.html" $ constA mempty
        >>> arr (setField "title" "Articles")
        >>> arr (setField "colourscheme" "colourslight")
        >>> requireAllA "articles/*" addPostList
        >>> applyTemplateCompiler "templates/articlelist.html"
        >>> applyTemplateCompiler "templates/base.html"
        >>> relativizeUrlsCompiler

    -- Render /projects.html 
    match  "projects.html" $ route idRoute
    create "projects.html" $ constA mempty
        >>> arr (setField "title" "Projects")
        >>> arr (setField "colourscheme" "colourslight")
        >>> requireAllA "projects/*" addPostList
        >>> applyTemplateCompiler "templates/articlelist.html"
        >>> applyTemplateCompiler "templates/base.html"
        >>> relativizeUrlsCompiler

    -- Render /articles.html
    match  "photography.html" $ route idRoute
    create "photography.html" $ constA mempty
        >>> arr (setField "title" "Photography")
        >>> arr (setField "colourscheme" "coloursdark")
        >>> requireAllA "photography/*" addPhotoList
        >>> applyTemplateCompiler "templates/articlelist.html"
        >>> applyTemplateCompiler "templates/base.html"
        >>> relativizeUrlsCompiler

    -- Render /about.html
    match ("about.md") $ do
        route   $ setExtension "html"
        compile $ pageCompiler
            >>> applyTemplateCompiler "templates/about.html"
            >>> applyTemplateCompiler "templates/base.html"
            >>> relativizeUrlsCompiler


    -- Render Index
    match ("index.md") $ do
        route   $ setExtension "html"
        compile $ pageCompiler
            >>> applyTemplateCompiler "templates/index.html"
            >>> applyTemplateCompiler "templates/base.html"
            >>> relativizeUrlsCompiler

    -- Render RSS feed
    match  "rss.xml" $ route idRoute
    create "rss.xml" $
        requireAll_ "articles/*" >>> renderRss feedConfiguration



-- | Auxiliary compiler: generate a post list from a list of given posts, and
-- add it to the current page under @$posts@
addPostList :: Compiler (Page String, [Page String]) (Page String)
addPostList = setFieldA "posts" $
    arr (reverse . recentFirst)
        >>> require "templates/articlelistitem.html" (\p t -> map (applyTemplate t) p)
        >>> arr mconcat
        >>> arr pageBody

addPhotoList :: Compiler (Page String, [Page String]) (Page String)
addPhotoList = setFieldA "posts" $
    arr (reverse . recentFirst)
    -- arr (reverse . chronological)
        >>> require "templates/photographylistitem.html" (\p t -> map (applyTemplate t) p)
        >>> arr mconcat
        >>> arr pageBody

feedConfiguration :: FeedConfiguration
feedConfiguration = FeedConfiguration
    { feedTitle       = "Victor Gan"
    , feedDescription = "The Personal Site of Victor Gan"
    , feedAuthorName  = "Victor Gan"
    , feedRoot        = "http://vgan.ca"
    }

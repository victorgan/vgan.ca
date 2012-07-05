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

    -- Copy javascript
    match "photos/*" $ do
        route idRoute
        compile copyFileCompiler

    -- Compress CSS
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    -- Copy photography page
    match ("photography.html") $ do
        route   $ idRoute
        compile $ copyFileCompiler

    -- Render blog posts
    match "articles/*" $ do
        route   $ setExtension ".html"
        compile $ pageCompiler
            >>> applyTemplateCompiler "templates/articlepage.html"
            >>> applyTemplateCompiler "templates/default.html"
            >>> relativizeUrlsCompiler

    -- Render project posts
    match "projects/*" $ do
        route   $ setExtension ".html"
        compile $ pageCompiler
            >>> applyTemplateCompiler "templates/articlepage.html"
            >>> applyTemplateCompiler "templates/default.html"
            >>> relativizeUrlsCompiler

    -- Render /articles.html
    match  "articles.html" $ route idRoute
    create "articles.html" $ constA mempty
        >>> arr (setField "title" "Articles")
        >>> requireAllA "articles/*" addPostList
        >>> applyTemplateCompiler "templates/articlelist.html"
        >>> applyTemplateCompiler "templates/default.html"
        >>> relativizeUrlsCompiler

    -- Render /projects.html 
    match  "projects.html" $ route idRoute
    create "projects.html" $ constA mempty
        >>> arr (setField "title" "Projects")
        >>> requireAllA "projects/*" addPostList
        >>> applyTemplateCompiler "templates/articlelist.html"
        >>> applyTemplateCompiler "templates/default.html"
        >>> relativizeUrlsCompiler


    -- Render /about.html
    match ("about.md") $ do
        route   $ setExtension "html"
        compile $ pageCompiler
            >>> applyTemplateCompiler "templates/about.html"
            >>> applyTemplateCompiler "templates/default.html"
            >>> relativizeUrlsCompiler


    -- Index
    match ("index.md") $ do
        route   $ setExtension "html"
        compile $ pageCompiler
            >>> applyTemplateCompiler "templates/index.html"
            >>> relativizeUrlsCompiler

    -- Render RSS feed
    match  "rss.xml" $ route idRoute
    create "rss.xml" $
        requireAll_ "articles/*" >>> renderRss feedConfiguration



-- | Auxiliary compiler: generate a post list from a list of given posts, and
-- add it to the current page under @$posts@
--
addPostList :: Compiler (Page String, [Page String]) (Page String)
addPostList = setFieldA "posts" $
    arr (reverse . sortByBaseName)
        >>> require "templates/articlelistitem.html" (\p t -> map (applyTemplate t) p)
        >>> arr mconcat
        >>> arr pageBody

feedConfiguration :: FeedConfiguration
feedConfiguration = FeedConfiguration
    { feedTitle       = "Victor Gan"
    , feedDescription = "The Personal Site of Victor Gan"
    , feedAuthorName  = "Victor Gan"
    , feedRoot        = "http://vgan.ca"
    }

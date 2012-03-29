Laptop
======

Laptop is a set of scripts to get your Max OS X laptop set up as a Rails development machine.

Install
-------

Uninstall XCode:

    sudo /Developer/Library/uninstall-devtools --mode=all

Install [Command Line Tools for XCode](https://developer.apple.com/downloads/index.action) (171MB).

Run our one-liner:

    bash < <(curl -s https://raw.github.com/thoughtbot/laptop/master/mac)

What it sets up
---------------

* SSH public key (for authenticating with services like Github and Heroku)
* Homebrew (for managing operating system libraries)
* Qt (used by Capybara Webkit for headless JavaScript testing)
* Ack (for ***REMOVED***nding things in ***REMOVED***les)
* Tmux (for saving project state and switching between projects)
* Postgres (for storing relational data)
* Redis (for storing key-value data)
* ImageMagick (for cropping and resizing images)
* RVM (for managing versions of the Ruby programming language)
* Ruby 1.9.2 stable (for writing general-purpose code)
* Bundler gem (for managing Ruby libraries)
* Rails gem (for writing web applications)
* Heroku gem (for interacting with the Heroku API)
* Taps gem (for pushing and pulling SQL databases between environments)
* Postgres gem (for making Ruby talk to SQL databases)
* Foreman gem (for serving your Rails app locally)
* Git Remote Branch gem (for faster git branch creation and deletion)
* Heroku accounts plugin (for using multiple Heroku accounts like a client's account)
* Heroku con***REMOVED***g plugin (for pulling con***REMOVED***g variables locally to be used as ENV variables)

It should take about 30 minutes for everything to install, depending on your machine.

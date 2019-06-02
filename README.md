## EH Starter Kit
A script to set up a macOS laptop for web development at Employment Hero. This script is inspired ans based on Thoughtbot/Laptop script.

It can be run multiple times on the same machine safely. It installs, upgrades, or skips packages based on what is already installed on the machine.

Requirements
------------

Make sure you can connect to GitHub using SSH. Checkout this for instruction: https://help.github.com/en/articles/connecting-to-github-with-ssh

**Only continue when complete this step:** https://help.github.com/en/articles/testing-your-ssh-connection 

Supported OS:

* macOS Sierra (10.12)
* macOS High Sierra (10.13)
* macOS Mojave (10.14)

Older versions may work but aren't regularly tested.
Bug reports for older versions are welcome.

Install
-------

Download the script:

```sh
git clone git@github.com:Thinkei/eh-starter-kit.git ~/eh-starter-kit
```

Review the script (avoid running scripts you haven't read!):

```sh
less mac
```

Modify the script to set `EH_NPM_TOKEN` and `BUNDLE_GEM__FURY__IO` key. You can ask for these keys in channel `#eh-eng-onboard`

Execute the downloaded script:

```sh
sh mac 2>&1 | tee ~/laptop.log
```

Optionally, review the log:

```sh
less ~/laptop.log
```

Debugging
---------

Your last Laptop run will be saved to `~/laptop.log`.
Read through it to see if you can debug the issue yourself.
If not, copy the lines where the script failed into a
[new GitHub Issue](https://github.com/Thinkei/eh-starter-kit/issues/new) for us.
Or, attach the whole log ***REMOVED***le as an attachment.

What it sets up
---------------

macOS tools:

* [Homebrew] for managing operating system libraries.

[Homebrew]: http://brew.sh/

Unix tools:

* [Exuberant Ctags] for indexing ***REMOVED***les for vim tab completion
* [Git] for version control
* [OpenSSL] for Transport Layer Security (TLS)
* [RCM] for managing company and personal dot***REMOVED***les
* [Watchman] for watching for ***REMOVED***lesystem events
* [Zsh] as your shell

[Exuberant Ctags]: http://ctags.sourceforge.net/
[Git]: https://git-scm.com/
[OpenSSL]: https://www.openssl.org/
[RCM]: https://github.com/thoughtbot/rcm
[Tmux]: http://tmux.github.io/
[Watchman]: https://facebook.github.io/watchman/
[Zsh]: http://www.zsh.org/

Heroku tools:

* [Heroku CLI] for interacting with the Heroku API

[Heroku CLI]: https://devcenter.heroku.com/articles/heroku-cli

GitHub tools:

* [Hub] for interacting with the GitHub API

[Hub]: http://hub.github.com/

Image tools:

* [ImageMagick] for cropping and resizing images

Programming languages, package managers, and con***REMOVED***guration:

* [Rbenv] for managing ruby versions
* [Bundler] for managing Ruby libraries
* [Node.js] and [NPM], for running apps and installing JavaScript packages
* [Ruby] stable for writing general-purpose code
* [Python] stable for writing general-purpose code
* [Yarn] for managing JavaScript packages
* [Docker] an application container, using for Auth service

[Bundler]: http://bundler.io/
[ImageMagick]: http://www.imagemagick.org/
[Node.js]: http://nodejs.org/
[NPM]: https://www.npmjs.org/
[ASDF]: https://github.com/asdf-vm/asdf
[Ruby]: https://www.ruby-lang.org/en/
[Yarn]: https://yarnpkg.com/en/
[Python]: https://www.python.org/
[Rbenv]: https://github.com/rbenv/rbenv

Databases:

* [Postgres] for storing relational data
* [Redis] for storing key-value data

[Postgres]: http://www.postgresql.org/
[Redis]: http://redis.io/

Customize in `~/.laptop.local`
------------------------------

Your `~/.laptop.local` is run at the end of the Laptop script.
Put your customizations there.
For example:

```sh
***REMOVED***

brew bundle --***REMOVED***le=- <<***REMOVED***
brew "Caskroom/cask/dockertoolbox"
brew "go"
brew "ngrok"
brew "watch"
***REMOVED***

default_docker_machine() {
  docker-machine ls | grep -Fq "default"
***REMOVED***

if ! default_docker_machine; then
  docker-machine create --driver virtualbox default
***REMOVED***

default_docker_machine_running() {
  default_docker_machine | grep -Fq "Running"
***REMOVED***

if ! default_docker_machine_running; then
  docker-machine start default
***REMOVED***

fancy_echo "Cleaning up old Homebrew formulae ..."
brew cleanup
brew cask cleanup

if [ -r "$HOME/.rcrc" ]; then
  fancy_echo "Updating dot***REMOVED***les ..."
  rcup
***REMOVED***
```

Write your customizations such that they can be run safely more than once.
See the `mac` script for examples.

Laptop functions such as `fancy_echo` and
`gem_install_or_update`
can be used in your `~/.laptop.local`.

We will create the [wiki](https://github.com/Thinkei/eh-starter-kit/wiki)
for more customization examples.

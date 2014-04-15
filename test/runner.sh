#!/usr/bin/env sh
source ./test/common

FAILED=false

vagrant_destroy() {
  if [ -z "$KEEP_VM" ]; then
    vagrant destroy --force
***REMOVED***
***REMOVED***

if ! vagrant -v | grep -qiE 'Vagrant 1.5'; then
  failure_message 'You must use vagrant >= 1.5.0 to run the test suite.'
  exit 1
***REMOVED***

message "Building latest scripts"
./bin/build.sh

for vagrant***REMOVED***le in test/Vagrant***REMOVED***le.*; do
  FAILED=false

  message "Testing with $vagrant***REMOVED***le"

  ln -sf "$vagrant***REMOVED***le" ./Vagrant***REMOVED***le || failure "Unable to link Vagrant***REMOVED***le $vagrant***REMOVED***le"

  message 'Destroying and recreating virtual machine'
  vagrant_destroy
  vagrant up || failure "$vagrant***REMOVED***le :: Unable to start virtual machine"

  # TODO: Create a Vagrant***REMOVED***le.mac that uses VMWare Fusion to run OSX
  if echo "$vagrant***REMOVED***le" | grep -q '\.mac$'; then
    vagrant ssh -c 'echo vagrant | bash /vagrant/mac' \
      || failure "$vagrant***REMOVED***le :: Installation script failed to run"
***REMOVED***
    vagrant ssh -c 'echo vagrant | bash /vagrant/linux' \
      || failure "$vagrant***REMOVED***le :: Installation script failed to run"
***REMOVED***

  vagrant ssh -c '[ "$SHELL" = "/usr/bin/zsh" ]' \
    || failure "$vagrant***REMOVED***le :: Installation did not set \$SHELL to ZSH"

  ruby_version="$(curl -sSL http://ruby.thoughtbot.com/latest)"

  vagrant ssh -c 'zsh -i -l -c "ruby --version" | grep -Fq "$ruby_version"' \
    || failure "$vagrant***REMOVED***le :: Installation did not install the correct ruby"

  vagrant ssh -c 'zsh -i -l -c "rm -Rf ~/test_app && cd ~ && rails new test_app"' \
    || failure "$vagrant***REMOVED***le :: Could not successfully create a rails app"

  vagrant ssh -c 'zsh -i -l -c "cd ~/test_app && rails g scaffold post title:string"' \
    || failure "$vagrant***REMOVED***le :: Could not successfully generate a scaffolded model"

  vagrant ssh -c 'zsh -i -l -c "cd ~/test_app && rake db:create db:migrate db:test:prepare"' \
    || failure "$vagrant***REMOVED***le :: Could not successfully initialize databases and migrate"

  vagrant ssh -c 'zsh -i -l -c "rm -Rf ~/test_app"'
  vagrant ssh -c 'zsh -i -l -c "sudo aptitude clean"'

  if [ "$FAILED" = true ]; then
    failure_message "$vagrant***REMOVED***le :: The automated tests failed. Please look for error messages above"
***REMOVED***
    message "$vagrant***REMOVED***le tests succeeded"
    if [ -n "$PACKAGE_BOXES" ];
      package_box
***REMOVED***
***REMOVED***

  vagrant halt
  sleep 30
  vagrant_destroy
  sleep 30
done

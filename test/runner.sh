#!/usr/bin/env sh
message() {
  printf "\e[1;34m:: \e[1;37m%s\e[0m\n" "$*"
***REMOVED***

failure() {
  printf "\n\e[1;31mFAILURE\e[0m: \e[1;37m%s\e[0m\n\n" "$*" >&2;
  continue
***REMOVED***

vagrant_destroy() {
  if [ -z "$KEEP_VM" ]; then
    vagrant destroy --force
***REMOVED***
***REMOVED***

message "Building latest scripts"
./bin/build.sh

for vagrant***REMOVED***le in test/Vagrant***REMOVED***le.*; do
  message "Testing with $vagrant***REMOVED***le"

  ln -sf "$vagrant***REMOVED***le" ./Vagrant***REMOVED***le || failure 'Unable to link Vagrant***REMOVED***le'

  message 'Destroying and recreating virtual machine'
  vagrant_destroy
  vagrant up || failure 'Unable to start virtual machine'

  # TODO: Create a Vagrant***REMOVED***le.mac that uses VMWare Fusion to run OSX
  if echo "$vagrant***REMOVED***le" | grep -q '\.mac$'; then
    vagrant ssh -c 'echo vagrant | bash /vagrant/mac' \
      || failure 'Installation script failed to run'
***REMOVED***
    vagrant ssh -c 'echo vagrant | bash /vagrant/linux' \
      || failure 'Installation script failed to run'
***REMOVED***

  vagrant ssh -c '[ "$SHELL" = "/usr/bin/zsh" ]' \
    || failure 'Installation did not set $SHELL to ZSH'

  vagrant ssh -c 'zsh -i -l -c "ruby --version" | grep -Fq "ruby 2.1.1"' \
    || failure 'Installation did not install the correct ruby'

  vagrant ssh -c 'zsh -i -l -c "rm -Rf ~/test_app && cd ~ && rails new test_app"' \
    || failure 'Could not successfully create a rails app'

  vagrant ssh -c 'zsh -i -l -c "cd ~/test_app && rails g scaffold post title:string"' \
    || failure 'Could not successfully generate a scaffolded model'

  vagrant ssh -c 'zsh -i -l -c "cd ~/test_app && rake db:create db:migrate db:test:prepare"' \
    || failure 'Could not successfully initialize databases and migrate'

  message "$vagrant***REMOVED***le tested successfully, shutting down VM"
  vagrant halt
  sleep 30
  vagrant_destroy
  sleep 30
done


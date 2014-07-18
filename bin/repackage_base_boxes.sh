***REMOVED***

for box in spec/vagrant***REMOVED***les/Vagrant***REMOVED***le.*; do
  base_name=$(basename "$box" '.box' | sed "s/Vagrant***REMOVED***le\.//")
  box_***REMOVED***le="${base_name***REMOVED***.box"

  if [ ! -e "$box_***REMOVED***le" ]; then
    ln -sf $box Vagrant***REMOVED***le

    vagrant destroy
    vagrant up
    echo "You'll now be dropped into an interactive shell in $base_name."
    echo "Make whatever changes are necessary and when you exit we'll repackage the box."
    vagrant ssh

    rm -f "$box_***REMOVED***le"
    vagrant package --base "laptop-$base_name" --output "$box_***REMOVED***le"

***REMOVED***
    echo "$base_name already packaged at $box_***REMOVED***le, skipping"
***REMOVED***
done

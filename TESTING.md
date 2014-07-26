# Testing

Laptop is tested by using it to provision a fresh VM. The process is lengthy
but scripted, and relies on Vagrant, ruby, and rspec.

Currently, only the linux script is tested.

## Prerequisites

1. [VirtualBox][]
2. [Vagrant][] - version >= 1.5.0
3. [aws-cli][] - optional, for publishers only.
4. A modern ruby that allows you to install gems.

[VirtualBox]: https://www.virtualbox.org/
[Vagrant]: http://www.vagrantup.com/
[aws-cli]: http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html

`aws-cli` is only necessary if you're one of the maintainers and want to
publish new "Laptop'ed" boxes.

## Running the tests

1. From the repository root:

```sh
bundle
bundle exec rake
```

## Details

For each ***REMOVED***le found at `./spec/vagrant***REMOVED***les/Vagrant***REMOVED***le.*`:

1. No specs are run if a rendered box already exists
2. Vagrant creates and starts a VM as described by the Vagrant***REMOVED***le
3. The appropriate Laptop script is run inside the VM
4. Some assertions are made against the VMs state
5. If all specs pass, then a vagrant box is rendered to the ***REMOVED***lesystem, ready to be published to s3

If you want to re-run specs (and therefore re-render new vagrant boxes with
laptop freshly applied to them), `rm *.box` in the repository root and Laptop
will be re-run against all Vagrant***REMOVED***les.

The "render box when specs are successful" workflow allows you to focus on
failing distros and re-run only those specs that've failed.

The following are the assertions:

1. The VM was brought up successfully
2. The Laptop script(s) ran successfully
3. The VM reports the correct `$SHELL`
4. The VM reports the correct ruby
5. A rails app can be created successfully
6. A scaffolded model can be created within that rails app
7. A default sqlite development and test database can be created and migrations can be run
8. `silver_searcher` (aka `ag`) is installed and available on `$PATH`.

Vagrant VMs are destroyed before specs are run for a speci***REMOVED***c Vagrant***REMOVED***le, so
the last VM will be available until you re-run or explicitly `vagrant destroy`.

Adding additional linux distros to test via this framework should be easy:
simply add a new Vagrant***REMOVED***le in the `./spec/vagrant***REMOVED***les/` directory which uses
a base box with the desired distribution.

OSX will need to be handled specially:

1. The [VMware][] provider will have to be used
2. Building an OSX base box may or may not be easy
3. The resulting test can only be run on an OSX host

[VMware]: http://www.vmware.com/

## Publishing updated boxes to s3

First, you'll need to install and con***REMOVED***gure [aws-cli].  When you're ready to
publish a new set of boxes:

1. Run the specs as described above, which will render passing boxes to the ***REMOVED***lesystem.
2. run `./bin/publish_laptopped_boxes.sh` to publish changed boxes to s3.

You do not need to re-create or update the box con***REMOVED***g in vagrantcloud for an
updated box, as long as the URL stays the same.

This will copy the new box to a temporary name, remove the original and move
the temp into place to minimize downtime.

It only publishes boxes that have a different ***REMOVED***le size locally than what's on
S3. Unfortunately, S3 does not return an md5sum for large ***REMOVED***les in a way that'd
be easy to compare to a local copy without downloading the entire ***REMOVED***le. So -
theoretically - if a new Laptop'ed box had the same size as the immediately
previous one, it would not get published to S3. This seems fairly unlikely,
given that we're dealing with an entire operating system.

## Removing a deprecated release

- Remove the vagrant***REMOVED***le under `spec/vagrant***REMOVED***les`
- Remove the ***REMOVED***les published to s3
- Remove the box con***REMOVED***g in vagrantcloud
- Update README.md

## Creating new base boxes to test a new release

1. Download a 64 bit minimal server ISO
1. Set up a new virtualbox machine
    - Name it logically: `ubuntu-14-04-server` or similar
    - 512 meg of RAM
    - 2 CPUs
    - 8 gig dynamically allocated disk, choosing the default VDI storage
1. Install. During installation:
    - Create a `vagrant` user with the password "vagrant"
    - Don't encrypt your home drive
    - Choose the minimal packages necessary to get a working SSH server
1. Reboot. And then follow the [general base box instructions][], speci***REMOVED***cally:
    - Log in as the `vagrant` user, `sudo -i` and then set root's password to 'vagrant'
    - Modify `/etc/sudoers` to allow vagrant password-less `sudo` for all commands
    - Install the vagrant insecure SSH keypair into the `vagrant` account
    - Set up guest additions according to the [virtualbox provider docs][]. See [this bug in 4.3.10][].
    - Update and clean up: `aptitude update && aptitude dist-upgrade -y && aptitude clean`
1. Package the new minimal base box.
    `vagrant package --base ubuntu-14-04-server --output ubuntu-14-04-server.box`
1. Test the new base box.
    - Add the box to your local vagrant: `vagrant box add ubuntu-14-04-server.box --name ubuntu-14-04-server`
    - Create a minimal `Vagrant***REMOVED***le` that uses your new box by name
    - `vagrant up`
    - Connect to your box via `vagrant ssh`
    - Make sure you can see shared ***REMOVED***les under the `/vagrant` directory.
    - If it works, clean up after yourself:
    - `vagrant destroy`
    - `vagrant box remove ubuntu-14-04-server`
    - Remove the release ISO if you're sure everything works.
1. Upload the new base box to s3. Assuming you have aws-cli installed:
    `aws s3 cp ubuntu-14-04-server.box s3://laptop-boxes/ --acl public-read`
1. Add a new box con***REMOVED***g to vagrantcloud, named and described logically.
    - Create a version (0.1.0) and a provider with the s3 URL you created above.
    - Release the con***REMOVED***g. It's OK if the box hasn't been uploaded to s3 yet,
      vagrantcloud issues a 302 when a box is requested.
1. Create a Vagrant***REMOVED***le under `spec/vagrant***REMOVED***les` that uses the vagrantcloud remote name.
1. Run the rspecs and see if the laptop tests succeed.
1. If tests completed successfully, you'll have a `*-with-laptop.box` ***REMOVED***le.
    Publish it via `./bin/publish_laptopped_boxes.sh` if you are a laptop maintainer.
1. Create another vagrantcloud box con***REMOVED***g, this time linking to the
    `-with-laptop.box` image you uploaded to s3.

[general base box instructions]:http://docs.vagrantup.com/v2/boxes/base.html
[virtualbox provider docs]:http://docs.vagrantup.com/v2/virtualbox/boxes.html
[this bug in 4.3.10]:https://github.com/dotless-de/vagrant-vbguest/issues/117

## chsh errors

The test script may fail when changing the vagrant user's shell to `zsh`. If
this happens, you need to con***REMOVED***gure PAM to allow a user to change their shell
without a password. Open '/etc/pam.d/chsh' and change the line:

    auth		suf***REMOVED***cient	pam_rootok.so

to

    auth		suf***REMOVED***cient	pam_permit.so

which will allow the vagrant user to change their shell without a password.
You'll need to repackage and re-upload the base box with this change.

Contributing
============

Laptop is broken into components to maximize sharing between operating systems
and linux distros, while retaining the easy hackability of a "single ***REMOVED***le"
installation.

To extend / modify laptop:

1) Find a component that most closely ***REMOVED***ts what you want to change. If nothing
seems appropriate, create a new one. The best way to learn about how the
components are split is to read the `manifests` and look at the contents of the
***REMOVED***les they reference. It is ultimately pretty simple.

2) Make your changes within the component, prioritizing "common-components"
that can be shared easily amongst manifests.  OS / distro-speci***REMOVED***c components
are ***REMOVED***ne, but be sure they are necessary ***REMOVED***rst.

3) Render the installation ***REMOVED***les from the manifests via the `./bin/build.sh`
script, run from the repo root. You should see your changes reflected in the
rendered `linux`, `linux-preqrequisites`, or `mac` ***REMOVED***les. `git diff` is your
friend - check the output. If it looks as expected, commit the rendered
installation ***REMOVED***les.

4) A reminder: be extra sure to render the installation ***REMOVED***les before
issuing a pull request.

Supporting additional distros or operating systems
==================================================

See above.  Ideally, you can mix-and-match existing components to do most of
the work, replacing only the `debian-package-update` and
`debian-derivative-packages` components with your distro-speci***REMOVED***c ***REMOVED***les. It
will probably be more work than that, but not much.

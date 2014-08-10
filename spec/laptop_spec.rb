require 'spec_helper'

describe 'Laptop applied to a vagrant box' do
  after do
    run_command('vagrant halt')
  end

  laptop_vagrant***REMOVED***les.each do |vagrant***REMOVED***le|
    it "should run laptop successfully for #{vagrant***REMOVED***le***REMOVED***" do
      distro = Distro.new(vagrant***REMOVED***le)
      distro.link_vagrant***REMOVED***le

      next if distro.packaged?

      puts "Testing #{distro.basename***REMOVED***"
      build_laptop_script

      distro.reset
      distro.prepare

      puts "Setting up laptop"

      expect { distro.setup_laptop ***REMOVED***.not_to raise_error

      expect(distro.active_shell).to match /zsh/
      expect(distro.installed_ruby_version).to match latest_ruby_version

      puts "Generating rails app"
      expect { distro.generate_rails_app ***REMOVED***.not_to raise_error
      expect { distro.scaffold_and_model_generation ***REMOVED***.not_to raise_error
      expect { distro.database_migration ***REMOVED***.not_to raise_error
      expect { distro.silver_searcher_test ***REMOVED***.not_to raise_error
      expect { distro.gh_test ***REMOVED***.not_to raise_error

      puts "Packaging box for distribution"

      distro.package
    end
  end
end

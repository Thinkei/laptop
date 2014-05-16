class Distro
  attr_reader :vagrant***REMOVED***le, :basename, :virtualbox_name, :rendered_box_name

  def initialize(vagrant***REMOVED***le)
    @vagrant***REMOVED***le = vagrant***REMOVED***le
    init_names
  end

  def link_vagrant***REMOVED***le
    vagrant***REMOVED***le_name = 'Vagrant***REMOVED***le'

    if File.exists?(vagrant***REMOVED***le_name)
      File.unlink(vagrant***REMOVED***le_name)
    end
    File.symlink(vagrant***REMOVED***le, vagrant***REMOVED***le_name)
  end

  def reset
    run_command('vagrant destroy --force')
    run_command('vagrant up')
  end

  def halt
    run_command('vagrant halt')
  end

  def prepare
    run_vagrant_ssh_command('sudo aptitude update')
    run_vagrant_ssh_command('sudo aptitude dist-upgrade -y')
  end

  def setup_laptop
    run_vagrant_ssh_command('echo vagrant | bash /vagrant/linux')
  end

  def active_shell
    run_vagrant_ssh_command_in_zsh_context('echo $SHELL')
  end

  def installed_ruby_version
    run_vagrant_ssh_command_in_zsh_context('ruby --version')
  end

  def generate_rails_app
    run_vagrant_ssh_command_in_zsh_context(
      'rm -Rf ~/test_app && cd ~ && rails new test_app'
    )
  end

  def scaffold_and_model_generation
    run_vagrant_ssh_command_in_zsh_context(
      'cd ~/test_app && rails g scaffold post title:string'
    )
  end

  def database_migration
    run_vagrant_ssh_command_in_zsh_context(
      'cd ~/test_app && rake db:create db:migrate db:test:prepare'
    )
  end

  def silver_searcher_test
    run_vagrant_ssh_command('command -v ag')
  end

  def package
    run_vagrant_ssh_command('rm -Rf ~/test_app')
    run_vagrant_ssh_command('sudo aptitude clean')

    run_command(
      %Q|vagrant package --base "#{virtualbox_name***REMOVED***" --output "#{rendered_box_name***REMOVED***"|
    )
  end

  def packaged?
    File.exists?(rendered_box_name)
  end

  private

  def init_names
    @basename = File.basename(vagrant***REMOVED***le).gsub('Vagrant***REMOVED***le.', '')
    @virtualbox_name = "laptop-#{basename***REMOVED***"
    @rendered_box_name = "#{basename***REMOVED***-with-laptop.box"
  end

  def run_vagrant_ssh_command(command)
    run_command("vagrant ssh -c '#{command***REMOVED***'")
  end

  def run_vagrant_ssh_command_in_zsh_context(command)
    run_command(%Q|vagrant ssh -c 'zsh -i -l -c "#{command***REMOVED***"'|)
  end

  def run_command(command)
   #  Cocaine::CommandLine.new(command, '', :logger => Logger.new(STDOUT)).run
    Cocaine::CommandLine.new(command, '').run
  end
end

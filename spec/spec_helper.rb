$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'cocaine'
require 'rspec'
require 'distro'

Dir["#{File.dirname(__FILE__)***REMOVED***/support/**/*.rb"].each {|f| require f***REMOVED***

RSpec.con***REMOVED***gure do |con***REMOVED***g|
  con***REMOVED***g.include LaptopHelper
end

def laptop_vagrant***REMOVED***les
  Dir['./spec/vagrant***REMOVED***les/Vagrant***REMOVED***le.*']
end

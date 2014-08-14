require 'active_record'
require 'rspec'
require 'employee'
require 'division'
require 'project'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    # Task.all.each { |task| task.destroy }
  end
end


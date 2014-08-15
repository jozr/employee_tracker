require 'active_record'
require 'rspec'
require 'employee'
require 'division'
require 'project'
require './lib/contribution'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Employee.all.each { |looplord| looplord.destroy }
    Division.all.each { |looplord| looplord.destroy }
    Contribution.all.each { |looplord| looplord.destroy }
    Project.all.each { |looplord| looplord.destroy }
  end
end


class Project < ActiveRecord::Base
  has_many :employees, :through => :contributions
  has_many :contributions
end

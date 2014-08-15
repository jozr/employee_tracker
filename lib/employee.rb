class Employee < ActiveRecord::Base
  belongs_to :divisions

  has_many :projects, :through => :contributions
  has_many :contributions
end

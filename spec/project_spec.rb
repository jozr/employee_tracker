require 'spec_helper'

describe Project do
  it 'should have many employees' do
    project1 = Project.create({:name => 'remodeling'})
    employee1 = Employee.create({:name => 'Bird Bob', :division_id => 567})
    project1.employees << employee1
    expect(project1.employees).to eq [employee1]
  end
end

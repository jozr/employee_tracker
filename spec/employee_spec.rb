require 'spec_helper'

describe Employee do
  it "lists out all employees in a division" do
    division1 = Division.create({:name => 'Bird Cage'})
    division2 = Division.create({:name => 'cars'})
    employee2 = Employee.create({:name => 'James Sevenson', :division_id => division1.id})
    employee1 = Employee.create({:name => 'Bird Bob', :division_id => division1.id})
    division1.employees.where(division_id:  division1.id).should eq [employee2, employee1]
  end

  it 'should have many projects' do
    project1 = Project.create({:name => 'remodeling'})
    employee1 = Employee.create({:name => 'Bird Bob', :division_id => 567})
    employee1.projects << project1
    expect(employee1.projects).to eq [project1]
  end
end

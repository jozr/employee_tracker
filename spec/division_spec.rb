require 'spec_helper'

describe Division do
  it 'has many employees' do
    division = Division.create({:name => 'Green'})
    employee1 = Employee.create({:name => 'Foo', :division_id => division.id})
    employee2 = Employee.create({:name => 'Boo', :division_id => division.id})
    division.employees.should eq [employee1, employee2]
  end

  it 'will not add an employee to a nonexistent division' do
    division1 = Division.create({:name => 'Bird Cage'})
    employee1 = Employee.create({:name => 'Bird Bob', :division_id => 3000})
    division1.employees.should eq []
  end

  it 'lists all projects for an employee' do
    employee1 = Employee.create({:name => 'Foo', :division_id => 456845})
    employee2 = Employee.create({:name => 'Boo', :division_id => 456745})
    project1 = Project.create({:name => 'sweeping'})
    project2 = Project.create({:name => 'roofing'})
    new_contribution = Contribution.create({:employee_id => employee1.id, :project_id => project1.id})
    employee1.contributions.should eq [new_contribution]
  end

  it 'adds an employee to a division' do
    division1 = Division.create({:name => 'sweeping'})
    employee1 = Employee.create({:name => 'Foo', :division_id => division1.id})
    employee2 = Employee.create({:name => 'Boo', :division_id => 456745})
    division1.employees.should eq [employee1]
  end
end

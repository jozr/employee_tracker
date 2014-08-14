require 'spec_helper'

describe Division do
  it 'has many employees' do
    division = Division.create({:name => 'Green'})
    employee1 = Employee.create({:name => 'Foo', :division_id => division.id})
    employee2 = Employee.create({:name => 'Boo', :division_id => division.id})
    division.employees.should eq [employee1, employee2]
  end
end

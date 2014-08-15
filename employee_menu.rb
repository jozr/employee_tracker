require 'active_record'
require './lib/employee'
require './lib/division'
require './lib/project'
require './lib/contribution'
require 'pry'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts '********** Employee Tracker **********'
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'ae' to add an employee and 'le' to list them."
    puts "Press 'ad' to add a division and 'ld' to list them."
    puts "Press 'ap' to add a project and 'lp' to list them."
    puts "Press 'ed' to list out all employees in a certain division"
    puts "Press 'ade' to assign a division to an employee."
    puts "Press 'ep' to add an employee to a project."
    puts "Press 'lep' to list the projects an employee is working on."
    puts "Press 's' to set a project as Current for an employee."
    puts "Press 'x' to exit."
    choice = gets.chomp
    case choice
    when 'ae'
      add
    when 'le'
      list_emp
    when 'ad'
      div
    when 'ld'
      list_div
    when 'x'
      exit
    when 'ade'
      add_div_to_emp
    when 'ed'
      employee_by_div
    when 'ap'
      add_project
    when 'lp'
      list_projects
    when 'ep'
      add_emp_to_pro
    when 'lep'
      list_emp_pro
    when 's'
      set_pro_current
    else
      puts 'NOT VALID'
    end
  end
end

def add
  puts "Who?"
  employee_name = gets.chomp
  employee = Employee.new({:name => employee_name})
  employee.save
  puts "'#{employee_name}' HAS BEEN ADDED"
end

def add_project
  puts "ADD A PROJECT:"
  project_name = gets.chomp
  project = Project.new({:name => project_name})
  project.save
  puts "'#{project_name}' HAS BEEN ADDED"
end

def add_div_to_emp
  list_div
  puts "ENTER A DIVISION:"
  division_name = gets.chomp.to_s
  if check_division_name(division_name) == true
    list_emp
    puts "ENTER AN EMPLOYEE:"
    emp_name = gets.chomp.to_s
    Employee.find_by(name: emp_name).update(division_id: Division.find_by(name: division_name).id)
    puts "EMPLOYEE ADDED TO DIVISION"
  else
    puts 'INVALID INPUT'
  end
end

def list_emp
  puts '***EMPLOYEES***'
  employees = Employee.all
  employees.each { |employee| puts employee.name }
end

def div
  puts 'ADD A DIVISION:'
  division_name = gets.chomp
  division = Division.new({:name => division_name})
  division.save
  puts "#{division_name} HAS BEEN ADDED"
end

def list_div
  puts '***DIVISIONS***'
  divisions = Division.all
  divisions.each { |division| puts division.name }
end

def check_division_name(user_division)
  divisions = Division.all
  result = ''
  divisions.each do |division|
    if division.name == user_division
      result = true
    else
      result = false
    end
  end
  result
end

def employee_by_div
  list_div
  puts "ENTER A DIVISION TO SEE EMPLOYEES:"
  user_div = gets.chomp
  div = Division.where(name: user_div)
  binding.pry
  emp = Employee.where(division_id: div.first.id)
  emp.each do |employee|
    puts "#{employee.name}"
  end
end

def list_projects
  projects = Project.all
  projects.each do |project|
    puts "#{project.updated_at}    #{project.name}"
  end
end

def add_emp_to_pro
  list_projects
  puts "ENTER A PROJECT:"
  pro_name = gets.chomp
  list_emp
  puts "ENTER AN EMPLOYEE:"
  emp_name = gets.chomp
  employee = Employee.find_by(name: emp_name)
  project = Project.find_by(name: pro_name)
  Contribution.create({:employee_id => employee.id, :project_id => project.id, :current => false})
  puts "EMPLOYEE ADDED TO PROJECT"
end

def list_emp_pro
  list_emp
  puts "CHOOSE EMPLOYEE"
  user_emp = gets.chomp
  employee =  Employee.find_by(name: user_emp)
  contributions = employee.contributions
  projects = []

  contributions.each do |i|
    projects << Project.where(id: i.project_id)
  end

  projects.each do |i|
    puts i.first.name
  end
end

def set_pro_current
  list_emp
  puts 'CHOOSE EMPLOYEE'
  user_emp = gets.chomp
  employee =  Employee.where(name: user_emp)
  contributions = Contribution.where(employee_id: employee.first.id)

  projects = []
  contributions.each do |i|
    projects << Project.where(id: i.project_id)
  end

  projects.each do |i|
    puts i.first.name
  end

  puts "CHOOSE PROJECT"
  user_project = gets.chomp
  project = Project.where(name: user_project)


  set_false = Contribution.where(employee_id: employee.id)
  set_false.first.update(current: false)

  emp = Contribution.where({employee_id: employee.first.id, project_id: project.first.id})
  emp.first.update(current: true)
end


welcome

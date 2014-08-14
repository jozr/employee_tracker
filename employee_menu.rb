require 'active_record'
require 'employee'
require 'division'
require 'project'

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
    puts "Press 'a' to add an employee and 'l' to list them."
    puts "Press 'd' to add a division and 'q' to list them."
    puts "Press 'e' to exit."
    puts "Press 'y' to assign a division to an employee."
    choice = gets.chomp
    case choice
    when 'a'
      add
    when 'l'
      list_emp
    when 'd'
      div
    when 'q'
      list_div
    when 'e'
      exit
    when 'y'
      add_div_to_emp
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
  puts "'#{employee_name}' has been added to your dominion of endentured servitude."
end

def add_div_to_emp
  list_div
  puts "What is the name of the division?"
  division_name = gets.chomp.to_s
  list_emp
  puts "Choose your human."
  emp_name = gets.chomp.to_s
  Employee.find_by(name: emp_name).update(division_id: Division.find_by(name: division_name).id)
  puts "Booyah."
end

def list_emp
  puts 'Here are your employees.'
  employees = Employee.all
  employees.each { |employee| puts employee.name }
end

def div
  puts 'What?'
  division_name = gets.chomp
  division = Division.new({:name => division_name})
  division.save
  puts "'#{division_name} added."
end

def list_div
  puts 'Here are your divisions.'
  divisions = Division.all
  divisions.each { |division| puts division.name }
end



welcome

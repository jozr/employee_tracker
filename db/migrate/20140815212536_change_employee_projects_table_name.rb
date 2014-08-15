class ChangeEmployeeProjectsTableName < ActiveRecord::Migration
  def change
    rename_table :employee_projects, :contributions
  end
end

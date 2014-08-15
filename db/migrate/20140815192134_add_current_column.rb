class AddCurrentColumn < ActiveRecord::Migration
  def change
    add_column :employee_projects, :current, :boolean
  end
end

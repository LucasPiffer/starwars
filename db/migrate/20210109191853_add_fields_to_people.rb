class AddFieldsToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :birth_year, :string
    add_column :people, :mass, :string
  end
end

class CreateStarcrafts < ActiveRecord::Migration[5.2]
  def change
    create_table :starcrafts do |t|
      t.string :name
      t.string :model
      t.string :url
      t.timestamps
    end

    create_table :people_starcrafts, id: false do |t|
      t.belongs_to :starcraft
      t.belongs_to :person
    end
  end
end

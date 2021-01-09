class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :url

      t.belongs_to :planet

      t.timestamps
    end
  end
end

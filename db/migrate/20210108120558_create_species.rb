class CreateSpecies < ActiveRecord::Migration[5.2]
  def change
    create_table :species do |t|
      t.string :name
      t.string :url
      t.timestamps
    end

    create_table :people_species, id: false do |t|
      t.belongs_to :species
      t.belongs_to :person
    end
  end
end

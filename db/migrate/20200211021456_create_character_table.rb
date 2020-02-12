class CreateCharacterTable < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :level
      t.integer :exp
      t.string :character_class
      t.string :race
      t.integer :number_of_groups
      t.string :creator
    end
  end
end

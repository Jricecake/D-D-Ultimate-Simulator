class CreateCharacterTable < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :level, default: 1
      t.integer :exp, default: 0
      t.string :character_class
      t.string :race
      t.integer :number_of_groups, default: 0
      t.string :creator
    end
  end
end

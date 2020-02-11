class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :race
      t.string :class
      t.integer :exp
      t.boolean :alive
      t.string :creator
    end
  end
end

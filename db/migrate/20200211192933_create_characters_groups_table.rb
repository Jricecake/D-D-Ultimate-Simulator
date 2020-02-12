class CreateCharactersGroupsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :characters_groups do |t|
      t.integer :character_id
      t.integer :group_id
    end
  end
end

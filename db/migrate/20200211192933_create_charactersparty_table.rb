class CreateCharacterspartyTable < ActiveRecord::Migration[5.2]
  def change
    create_table :charactersparty do |t|
      t.integer :character_id
      t.integer :party_id
    end
  end
end

class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :available, default: true
      t.boolean :out_on_quest, default: false
    end
  end
end

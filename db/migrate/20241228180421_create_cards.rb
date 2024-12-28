class CreateCards < ActiveRecord::Migration[7.2]
  def change
    create_table :cards do |t|
      t.string :name
      t.text :desc
      t.integer :colors
      t.integer :rarity
      t.integer :card_type
      t.string :image

      t.timestamps
    end
  end
end

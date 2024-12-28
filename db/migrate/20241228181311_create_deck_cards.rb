class CreateDeckCards < ActiveRecord::Migration[7.2]
  def change
    create_table :deck_cards do |t|
      t.integer :deck_id, index: true
      t.integer :card_id, index: true
      t.integer :amount, default: 1
      t.string :card_name

      t.timestamps
    end
  end
end

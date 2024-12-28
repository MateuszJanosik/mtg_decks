class CreateDecks < ActiveRecord::Migration[7.2]
  def change
    create_table :decks do |t|
      t.string :name
      t.integer :colors
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end

class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.integer :user_id, index: true
      t.text :content
      t.integer :related_id
      t.string :related_type

      t.timestamps
    end
  end
end

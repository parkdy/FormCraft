class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :title, null: false
      t.text :description
      t.integer :author_id, null: false

      t.timestamps
    end

    add_index :forms, :author_id
  end
end

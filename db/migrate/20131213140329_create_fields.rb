class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :type, null: false
      t.integer :form_id, null: false
      t.string :label
      t.string :default

      t.timestamps
    end

    add_index :fields, :form_id
  end
end

class CreateFieldOptions < ActiveRecord::Migration
  def change
    create_table :field_options do |t|
      t.integer :field_id, null: false
      t.string :value, null: false
      t.string :label, null: false

      t.timestamps
    end

    add_index :field_options, :field_id
  end
end

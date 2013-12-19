class CreateFieldData < ActiveRecord::Migration
  def change
    create_table :field_data do |t|
      t.integer :field_id, null: false
      t.integer :response_id, null: false
      t.string :value, null: false

      t.timestamps
    end

    add_index :field_data, :field_id
    add_index :field_data, :response_id
    add_index :field_data, [:response_id, :field_id], unique: true
  end
end

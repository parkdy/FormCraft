class AddNameToFields < ActiveRecord::Migration
  def change
    add_column :fields, :name, :string, null: false
    add_index :fields, [:name, :form_id], unique: true
  end
end

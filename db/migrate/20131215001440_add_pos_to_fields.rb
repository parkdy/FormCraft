class AddPosToFields < ActiveRecord::Migration
  def change
    add_column :fields, :pos, :integer, null: false
    add_index :fields, [:pos, :form_id], unique: true
  end
end

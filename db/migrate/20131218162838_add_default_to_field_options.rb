class AddDefaultToFieldOptions < ActiveRecord::Migration
  def change
    add_column :field_options, :default, :boolean, default: false, null: false
  end
end

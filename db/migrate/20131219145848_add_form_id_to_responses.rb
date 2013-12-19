class AddFormIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :form_id, :integer
    add_index :responses, :form_id
  end
end

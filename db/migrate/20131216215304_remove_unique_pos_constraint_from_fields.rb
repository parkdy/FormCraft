class RemoveUniquePosConstraintFromFields < ActiveRecord::Migration
  def change
    remove_index :fields, [:pos, :form_id]
  end
end

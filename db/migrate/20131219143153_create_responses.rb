class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.boolean :read, default: false, null: false

      t.timestamps
    end
  end
end

class AddActivatedAndActivationTokenToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :activated, :boolean, default: false, null: false
  	add_column :users, :activation_token, :string
  end
end

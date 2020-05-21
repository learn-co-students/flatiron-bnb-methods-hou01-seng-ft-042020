class ChangeDefaultInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :host, :boolean, default: false
  end
end

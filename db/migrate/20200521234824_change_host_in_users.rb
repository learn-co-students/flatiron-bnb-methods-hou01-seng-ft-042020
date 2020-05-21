class ChangeHostInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :host, :boolean
  end
end

class RemoveHostFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :host, :string
  end
end

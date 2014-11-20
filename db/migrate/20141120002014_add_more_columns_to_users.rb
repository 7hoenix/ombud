class AddMoreColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :description, :string
    add_column :users, :headline, :string
  end
end

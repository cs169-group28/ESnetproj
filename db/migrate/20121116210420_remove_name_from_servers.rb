class RemoveNameFromServers < ActiveRecord::Migration
  def up
    remove_column :servers, :name
  end

  def down
    add_column :servers, :name, :string
  end
end

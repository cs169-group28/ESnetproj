class RemoveStateFromServers < ActiveRecord::Migration
  def up
    remove_column :servers, :state
  end

  def down
    add_column :servers, :state, :string
  end
end

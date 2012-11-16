class RemoveLatitudeFromServers < ActiveRecord::Migration
  def up
    remove_column :servers, :latitude
  end

  def down
    add_column :servers, :latitude, :string
  end
end

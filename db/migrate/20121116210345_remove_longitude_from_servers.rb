class RemoveLongitudeFromServers < ActiveRecord::Migration
  def up
    remove_column :servers, :longitude
  end

  def down
    add_column :servers, :longitude, :string
  end
end

class RemoveCityFromServers < ActiveRecord::Migration
  def up
    remove_column :servers, :city
  end

  def down
    add_column :servers, :city, :string
  end
end

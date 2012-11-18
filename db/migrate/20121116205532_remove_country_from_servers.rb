class RemoveCountryFromServers < ActiveRecord::Migration
  def up
    remove_column :servers, :country
  end

  def down
    add_column :servers, :country, :string
  end
end

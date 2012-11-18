class RemoveZipFromServers < ActiveRecord::Migration
  def up
    remove_column :servers, :zip
  end

  def down
    add_column :servers, :zip, :integer
  end
end

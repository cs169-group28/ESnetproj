class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.text :ip
      t.text :name
      t.text :country
      t.integer :zip
      t.text :city
      t.text :state
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end

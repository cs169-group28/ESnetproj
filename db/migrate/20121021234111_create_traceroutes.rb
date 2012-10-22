class CreateTraceroutes < ActiveRecord::Migration
  def change
    create_table :traceroutes do |t|

      t.timestamps
    end
  end
end

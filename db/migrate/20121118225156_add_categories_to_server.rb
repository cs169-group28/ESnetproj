class AddCategoriesToServer < ActiveRecord::Migration
  def change
    add_column :servers, :categories, :string
  end
end

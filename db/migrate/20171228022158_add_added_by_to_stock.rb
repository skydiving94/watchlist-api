class AddAddedByToStock < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :added_by, :string
  end
end

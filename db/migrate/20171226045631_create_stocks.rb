class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :code
      t.string :name
      t.float :highest
      t.float :lowest
      t.float :current
      t.float :difference

      t.timestamps
    end
  end
end

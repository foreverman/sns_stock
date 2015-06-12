class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
    add_index :stocks, :code, unique: true
    add_index :stocks, :name, unique: true
  end
end

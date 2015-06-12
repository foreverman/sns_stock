class CreateStockHeatRanks < ActiveRecord::Migration
  def change
    create_table :stock_heat_ranks do |t|
      t.belongs_to :stock
      t.integer :heat, default: 0
      t.date :date
      t.integer :post_count, default: 0

      t.timestamps null: false
    end
    add_index :stock_heat_ranks, [:stock_id, :date], unique: true
    add_index :stock_heat_ranks, :heat
  end
end

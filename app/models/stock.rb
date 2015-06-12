class Stock < ActiveRecord::Base
  has_many :heat_ranks, class_name: 'StockHeatRank'

  def symbol
    prefix = code.start_with?('6') ?  "SH" : "SZ"
    "#{prefix}#{code}"
  end
end

class ConvertGpToUseDecimal < ActiveRecord::Migration
  def change
    change_column :log_entries, :gp_gained, :decimal, precision: 20, scale: 4
  end
end

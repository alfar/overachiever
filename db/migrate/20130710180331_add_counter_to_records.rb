class AddCounterToRecords < ActiveRecord::Migration
  def change
    add_column :records, :counter, :bigint
  end
end

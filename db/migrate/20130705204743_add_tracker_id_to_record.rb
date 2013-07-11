class AddTrackerIdToRecord < ActiveRecord::Migration
  def change
    add_column :records, :tracker_id, :integer
  end
end

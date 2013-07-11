class AddWebsiteIdToTrackers < ActiveRecord::Migration
  def change
    add_column :trackers, :website_id, :integer
  end
end

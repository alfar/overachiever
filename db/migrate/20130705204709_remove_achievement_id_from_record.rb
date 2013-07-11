class RemoveAchievementIdFromRecord < ActiveRecord::Migration
  def up
    remove_column :records, :achievement_id
  end

  def down
    add_column :records, :achievement_id, :integer
  end
end

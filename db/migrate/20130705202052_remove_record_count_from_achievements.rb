class RemoveRecordCountFromAchievements < ActiveRecord::Migration
  def up
    remove_column :achievements, :record_count
  end

  def down
    add_column :achievements, :record_count, :integer
  end
end

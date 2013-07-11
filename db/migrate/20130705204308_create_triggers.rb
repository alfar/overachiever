class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.integer :tracker_id
      t.integer :threshold

      t.timestamps
    end
  end
end

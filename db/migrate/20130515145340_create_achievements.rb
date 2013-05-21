class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.string :name
      t.text :description
      t.text :notes
      t.integer :record_count, :default => 1
      t.integer :website_id

      t.timestamps
    end
  end
end

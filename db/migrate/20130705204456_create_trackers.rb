class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

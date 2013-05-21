class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :achievement_id
      t.string :user

      t.timestamps
    end
  end
end

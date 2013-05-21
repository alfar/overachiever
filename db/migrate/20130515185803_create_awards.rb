class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :to
      t.integer :achievement_id

      t.timestamps
    end
  end
end

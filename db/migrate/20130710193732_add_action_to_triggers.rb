class AddActionToTriggers < ActiveRecord::Migration
  def change
    add_column :triggers, :action, :int
    add_column :triggers, :object, :int
  end
end

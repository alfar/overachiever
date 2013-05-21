class Record < ActiveRecord::Base
  attr_accessible :achievement_id, :user
  belongs_to :achievement
end

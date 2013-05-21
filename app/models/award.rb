class Award < ActiveRecord::Base
  attr_accessible :achievement_id, :to
  belongs_to :achievement
end

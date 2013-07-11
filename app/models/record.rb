class Record < ActiveRecord::Base
  attr_accessible :tracker_id, :user, :counter
  belongs_to :tracker
end

class Website < ActiveRecord::Base
  attr_accessible :domain, :name, :owner
  has_many :achievements
  has_many :awards, :through => :achievements, :uniq => true
  has_many :trackers
  has_many :records, :through => :trackers
  has_many :triggers, :through => :trackers
end

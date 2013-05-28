class Website < ActiveRecord::Base
  attr_accessible :domain, :name, :owner
  has_many :achievements
  has_many :awards, :through => :achievements, :uniq => true
  has_many :records, :through => :achievements
end

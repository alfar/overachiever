class Website < ActiveRecord::Base
  attr_accessible :domain, :name, :owner
  has_many :achievements
end

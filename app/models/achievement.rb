class Achievement < ActiveRecord::Base
  attr_accessible :description, :name, :record_count, :notes, :website_id
  belongs_to :website
  has_many :awards, :uniq => true
  has_many :records
  
  def award(user_id)
    @awards = Award.find_by_achievement_id_and_to(self.id, user_id)
    if @awards.blank?
      @award = Award.new(:achievement_id => self.id, :to => user_id)
      @award.save
      return "Achievement awarded to " + user_id
    else
      return "Achievement already awarded to " + user_id
    end
  end
  
  def unaward(user_id)
    @unaward = Award.find_by_achievement_id_and_to(self.id, user_id)
    @unaward.destroy
    return "Achievement removed for " + user_id
  end
end

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
      Record.destroy_all(:achievement_id => self.id, :user => user_id)
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
  
  def record(user_id)
    size = Record.count(:conditions => { :achievement_id => self.id, :user => user_id } )
    if (size + 1) >= self.record_count
      return self.award(user_id)
    else
      @record = Record.new(:achievement_id => self.id, :user => user_id)
      @record.save
      return "Activity recorded for " + user_id
    end
  end
end

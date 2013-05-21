class Achievement < ActiveRecord::Base
  attr_accessible :description, :name, :record_count, :notes, :website_id
  belongs_to :website
  has_many :awards
  has_many :records
  
  def award(user)
    @awards = Award.find_by_achievement_id_and_to(self.id, user)
    if @awards.blank?
      @award = Award.new(:achievement_id => self.id, :to => user)
      @award.save
      Record.destroy_all(:achievement_id => self.id, :user => user)
      return "Achievement awarded to " + user
    else
      return "Achievement already awarded to " + user
    end
  end
  
  def unaward(user)
    @unaward = Award.find_by_achievement_id_and_to(self.id, user)
    @unaward.destroy
    return "Achievement removed for " + user
  end
  
  def record(user)
    size = Record.count(:conditions => { :achievement_id => self.id, :user => user } )
    if (size + 1) >= self.record_count
      return self.award(user)
    else
      @record = Record.new(:achievement_id => self.id, :user => user)
      @record.save
      return "Activity recorded for " + user
    end
  end
end

class Trigger < ActiveRecord::Base
  attr_accessible :threshold, :tracker_id, :action, :object
  belongs_to :tracker
  
  def action_to_s
    case action
    when 0
      return "Unaward an achievement"
    when 1
      return "Award an achievement"
    else
      return "Undefined"
    end
  end
  
  def object_type
    case action
    when 0
      return "Achievement"
    when 1
      return "Achievement"
    else
      return "Undefined"
    end
  end
  
  def object_link
    case object_type
    when "Achievement"
      return "/achievements/" + object.to_s
    else
      return "/websites"
    end
  end
  
  def object_name
    case object_type
    when "Achievement"
      achievement = Achievement.find_by_id(object)
      if achievement.blank?
        return "Undefined"
      else
        return achievement.name
      end
    else
      return "Undefined"
    end
  end
  
  def pull(record)
    case action
    when 0
      return Achievement.find(object).unaward(record.user)
    when 1
      return Achievement.find(object).award(record.user)
    else
      return "Error: Trigger has an invalid action."
    end
  end
end

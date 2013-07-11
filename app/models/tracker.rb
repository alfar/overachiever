class Tracker < ActiveRecord::Base
  attr_accessible :description, :name, :website_id
  belongs_to :website
  has_many :triggers
  has_many :records

  def record(user_id)
    @records = self.records.where(:user => user_id)
    if @records.empty?
      @record = Record.new(:tracker_id => self.id, :user => user_id, :counter => 1)
      @record.save
    else
      @records.each do |record|
        record.increment!(:counter)
        check_triggers(record)
      end
    end
    return "<li>" + user_id + "'s activity has been recorded.</li>"
  end
  
  def check_triggers(record)
    triggers.each do |trigger|
      check_trigger(trigger, record)
    end
  end
  
  def check_trigger(trigger, record)
    if record.counter >= trigger.threshold
      trigger.pull(record)
    end
  end
end

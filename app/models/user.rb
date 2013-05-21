class User < ActiveRecord::Base
  attr_accessible :name
  has_many :authorizations
  
  def self.create_from_hash!(hash)
    create(:name => hash['info']['name'])
  end
  
  def user_has_account(provider)
    return !Account.first(:conditions => { :user_id => self.id, :provider => provider }, :limit => 1).blank?
  end
  
end
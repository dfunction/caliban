class Pointer < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  
  @@acceptableTypes = ["phoneNumber", "emailAddress"]
  
  def self.acceptableTypes
    @@acceptableTypes
  end
  
  validates :type, presence: true, inclusion: {:in => @@acceptableTypes}
  validates :value, presence: true
  
  belongs_to :contact
  
  private
end

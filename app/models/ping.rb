class Ping < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  @@acceptableFrequencies = ["daily", "weekly", "monthly", "yearly"]
  
  def self.acceptableFrequencies
    @@acceptableFrequencies
  end

  validates :frequency, presence: true, inclusion: {:in => @@acceptableFrequencies}  
  validates :type, presence: true, inclusion: {:in => Pointer.acceptableTypes}
  validates :user, presence: true, associated: true
  
  belongs_to :user
  has_one :contactping, dependent: :destroy
  has_one :contact, through: :contactping
  
  accepts_nested_attributes_for :contactping
end

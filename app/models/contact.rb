class Contact < ActiveRecord::Base
  validates :name, presence: true
  validates :user, presence: true, associated: true
  validates :pointer, presence: true
  
  before_destroy do |c| c.pings.each do |p| p.destroy end end
    
  belongs_to :user
  has_one :pointer, dependent: :destroy
  has_many :contactpings, dependent: :destroy
  has_many :pings, through: :contactpings
  
  accepts_nested_attributes_for :pointer, allow_destroy: true
  
end

class User < ActiveRecord::Base
	validates :eid, presence: true, uniqueness: true
	validates :name, presence: true
	validates :email, uniqueness: true
	validates :phoneNumber, allow_nil: true, allow_blank: true, uniqueness: true
	
	has_many :contacts, dependent: :destroy
	has_many :pings, dependent: :destroy
end

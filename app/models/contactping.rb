class Contactping < ActiveRecord::Base
	belongs_to :ping
	belongs_to :contact
	
end
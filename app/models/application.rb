class Application
	def self.sendReminders
		User.all.each do |user|
			user.pings.each do |ping|
				if String(ping.type) == "phoneNumber" && shouldCall(ping)
					number_to_send_to = user.phoneNumber

					twilio_sid = "AC1a057c4ef9b61bfea3ae563095517e74"
					twilio_token = "8ba03065b764623ef90b5e301a1c89b8"
					twilio_phone_number = "3142660506"

					@twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

					suppress(Exception) do
						if (@twilio_client.account.sms.messages.create(
							:from => "+1#{twilio_phone_number}",
							:to => number_to_send_to,
							:body => "#{user.name}, call #{ping.contact.name} @ #{ping.contact.pointer.value}"
						))
							ping.update(lastRun: Time.now.utc)
						end
					end
				end
			end
		end
	end

	def self.shouldCall(ping)
		@lastRun = ping.lastRun ? ping.lastRun : ping.created_at

		case ping.frequency
		when "daily"
			@offset = 24 * 60 * 60
		when "weekly"
			@offset = 7 * 24 * 60 * 60
		when "monthly"
			@offset = 4.348 * 7 * 24 * 60 * 60
		when "yearly"
			@offset = 365.2425 * 24 * 60 * 60
		else
			ping.destroy
			return false
		end

		@nextRun = @lastRun + @offset
		@currentDate = Time.now.utc

		if (@nextRun.year <= @currentDate.year &&
			  @nextRun.month <= @currentDate.month &&
			  @nextRun.day <= @currentDate.day)
			return true
		else
			return false
		end
	end
end

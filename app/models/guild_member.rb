class GuildMember < ActiveRecord::Base
	def attend_event
		self.increment!(:points, 10)
	end
	
	def attended_on_time
		self.increment!(:points, 2)
	end
end

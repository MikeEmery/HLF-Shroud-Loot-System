class GuildMember < ActiveRecord::Base
	
	validates_presence_of :name
	validates_uniqueness_of :name
	
	def left_early
		self.decrement!(:points, 5)
	end
	
	def attend_event
		self.increment!(:points, 10)
	end
	
	def attended_on_time
		self.increment!(:points, 2)
	end
end

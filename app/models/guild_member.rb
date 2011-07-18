class GuildMember < ActiveRecord::Base
	
	has_many :point_adjustments
	
	validates_presence_of :name
	validates_uniqueness_of :name
	
	scope :active, where(:active => true)  
	
	def left_early
		amount = 5
		self.decrement!(:points, amount)
		self.point_adjustments.create(:reason => "Left early", :amount => -amount)
	end
	
	def attend_event
		amount = 10
		self.increment!(:points, amount)
		self.point_adjustments.create(:reason => "Attended raid", :amount => amount)
	end
	
	def attended_on_time
		amount = 2
		self.increment!(:points, amount)
		self.point_adjustments.create(:reason => "Arrived on time", :amount => amount)
	end
	
	def win_item(current_high, comments = nil)
		self.decrement!(:points, current_high)
		self.point_adjustments.create(:reason => "Won item", :amount => -current_high, :comments => comments )
	end
	
	def standby
	  amount = 5
	  self.increment!(:points, amount)
	  self.point_adjustments.create(:reason => "Standby", :amount => amount)
  end
end

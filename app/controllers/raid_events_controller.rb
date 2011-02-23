class RaidEventsController < ApplicationController
	
	before_filter :require_logged_in, :except => [:summary]
	
	def summary
	  @point_adjustments = PointAdjustment.order("id desc").limit(5)
	  @last_adjustment = PointAdjustment.last
	  
	  if(@last_adjustment)
	    @update_ui = session[:last_adjustment_id] != @last_adjustment.id
	    session[:last_adjustment_id] = @last_adjustment.id
    end
  end
	
	def create
		params[:attended] ||= []
		params[:on_time] ||= []
		params[:left_early] ||= []
		params[:standby] ||= []
		params[:bids] ||= {}
		
		params[:attended].each do |name|
			member = GuildMember.find_by_name(name)
			member.attend_event
		end
		
		params[:left_early].each do |name|
			member = GuildMember.find_by_name(name)
			member.left_early
		end
		
		params[:standby].each do |name|
		  member = GuildMember.find_by_name(name)
		  member.standby
	  end
		
		params[:on_time].each do |name|
			member = GuildMember.find_by_name(name)
			member.attended_on_time
		end
		
		bids = {}
		
		params[:bids].each do |name, bid_type|
			member = GuildMember.find_by_name(name)	
			bid_points = 0
			
			if(bid_type == "lfc")
				bid_points = 10
			elsif(bid_type == "half")
				
				next if member.points <= 0
				bid_points = (member.points / 2).ceil
			end
			
			bids[member.name] = bid_points
		end
		
		resolve_bids(bids) if bids.size > 0
		
		redirect_to guild_members_path
	end
	
	private
	def resolve_bids(bids)
		sorted_bids = bids.to_a.sort{ |a, b| b[1] <=> a[1] }
		
		winners = []
		
		current_high = -1
		
		sorted_bids.each do |name, bid|
			if(bid >= current_high)
				current_high = bid
				winners << name
			end
		end
		
		if(sorted_bids.size == 1)
			current_high = 10
		end
		
		calculate_winner(winners, current_high)
	end
	
	def calculate_winner(winners, point_cost)

		rolls = { }
		
		winners.each do |winner|
			rolls[rand(10000)+1] = winner
		end
		
		sorted_rolls = rolls.sort.reverse
		
		winner = sorted_rolls.first[1]
		
		roll_text = ""
		roll_text = "  Rolls: #{sorted_rolls.inspect}" if (sorted_rolls.size > 1)
		
		guild_member = GuildMember.find_by_name(winner)
		guild_member.win_item(point_cost, sorted_rolls.inspect.to_s)
		flash[:success] = ("<strong>#{winner}</strong> won the item." << roll_text).html_safe
	end
end

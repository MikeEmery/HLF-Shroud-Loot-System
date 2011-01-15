class RaidEventsController < ApplicationController
	
	before_filter :require_logged_in
	
	def create
		params[:attended] ||= []
		params[:on_time] ||= []
		params[:left_early] ||= []
		params[:bids] ||= {}
		
		params[:attended].each do |name|
			member = GuildMember.find_by_name(name)
			member.attend_event
		end
		
		params[:left_early].each do |name|
			member = GuildMember.find_by_name(name)
			member.left_early
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
		
		winner = winners[rand(winners.size)]
		
		guild_member = GuildMember.find_by_name(winner)
		guild_member.win_item(current_high)
		
		flash[:success] = "<strong>#{winner}</strong> won the item.".html_safe
	end
end

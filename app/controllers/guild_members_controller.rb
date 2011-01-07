class GuildMembersController < ApplicationController
	def index
		@guild_members = GuildMember.order("name")
	end
	
	def create
		@guild_member = GuildMember.new(params[:guild_member])
		@guild_member.save
		
		redirect_to guild_members_path
	end
end

class GuildMembersController < ApplicationController
	def index
		@guild_members = GuildMember.where(:active => true).order("name")
		@inactive_members = GuildMember.where(:active => false).order('name')
		@point_adjustments = PointAdjustment.order("id desc").limit(5)
	end
	
	def show
		@guild_member = GuildMember.find(params[:id])
		
		@point_adjustments = @guild_member.point_adjustments
	end
	
	def update
		@guild_member = GuildMember.find(params[:id])
		
		if(@guild_member.update_attributes(params[:guild_member]))
			redirect_to @guild_member
		else
			render :action => 'show'
		end
	end
	
	def create
		@guild_member = GuildMember.new(params[:guild_member])
		unless(@guild_member.save)
			flash[:error] = @guild_member.errors.map{ |k, v| "#{k} #{v}" }.join("<br/>").html_safe
		end
		
		redirect_to guild_members_path
	end
end

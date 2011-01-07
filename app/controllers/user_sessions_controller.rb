class UserSessionsController < ApplicationController
	def new
	end
	
	def create
		session[:password] = params[:password]
		redirect_to guild_members_path
	end
	
	def end
		reset_session
		redirect_to guild_members_path
	end
end

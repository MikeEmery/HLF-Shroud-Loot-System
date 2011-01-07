class ApplicationController < ActionController::Base
  protect_from_forgery

	helper_method :logged_in?
	
	def logged_in?
		session[:password] == "flamingdeath"
	end
	
	def require_logged_in
		redirect_to guild_members_path unless logged_in?
	end
end

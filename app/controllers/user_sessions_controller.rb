class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new()
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_back_or_default guild_members_url
    else
			flash[:error] = "Incorrect password"
      render :action => :new
    end
  end
  
	def end
    current_user_session.destroy
		reset_session
    flash[:notice] = "Logout successful!"
    redirect_back_or_default guild_members_url
  end
end

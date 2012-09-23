class AccountsController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      UserSession.create(@user, true)
      redirect_to guild_members_path
    else
      render :action => :new
    end
  end
end

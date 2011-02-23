class PointAdjustmentsController < ApplicationController
  def create
    @point_adjustment = PointAdjustment.create!(params[:point_adjustment])
    @point_adjustment.guild_member.increment!(:points, @point_adjustment.amount)
    redirect_to guild_member_path(@point_adjustment.guild_member)
  end
end
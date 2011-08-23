module ApplicationHelper
  def member_points(guild_member)
    points = "-"
    
    if(logged_in? && (admin? || (current_user.login.downcase == guild_member.name.downcase)))
      points = guild_member.points
    end
    
    points
  end
  
  def points(point_adjustment)
    points = "-"
    
    if(logged_in? && (admin? || (current_user.login.downcase == point_adjustment.guild_member.name.downcase)))
      points = point_adjustment.amount
    end
    
    points
  end
end

module ApplicationHelper
  def member_points(guild_member)
    
    points = "-"
    
    if(logged_in? && (admin? || (current_user.login == guild_member.name)))
      points = guild_member.points
    end
    
    points
  end
  
  def points(point_adjustment)
    points = "-"
    
    if(logged_in? && (admin? || (current_user.login == point_adjustment.guild_member.name)))
      points = point_adjustment.amount
    end
    
    points
  end
end

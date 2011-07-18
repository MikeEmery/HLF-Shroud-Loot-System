class AddActiveToGuildMembers < ActiveRecord::Migration
  def self.up
		add_column :guild_members, :active, :boolean, :null => false, :default => true
  end

  def self.down
		remove_column :guild_members, :active
  end
end

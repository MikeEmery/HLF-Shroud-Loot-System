class AddActiveToGuildMembers < ActiveRecord::Migration
  def self.up
		add_column :guild_members, :active, :boolean, :default => true
  end

  def self.down
		remove_column :guild_members, :active
  end
end

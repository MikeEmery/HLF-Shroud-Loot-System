class CreateGuildMembers < ActiveRecord::Migration
  def self.up
    create_table :guild_members do |t|
			t.string :name
			t.integer :points, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :guild_members
  end
end

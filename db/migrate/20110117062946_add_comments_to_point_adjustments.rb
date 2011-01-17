class AddCommentsToPointAdjustments < ActiveRecord::Migration
  def self.up
		add_column :point_adjustments, :comments, :string
  end

  def self.down
		remove_column :point_adjustments, :comments
  end
end

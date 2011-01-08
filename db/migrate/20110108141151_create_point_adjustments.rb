class CreatePointAdjustments < ActiveRecord::Migration
  def self.up
    create_table :point_adjustments do |t|
			t.integer :amount
			t.references :guild_member
			t.string :reason
      t.timestamps
    end
  end

  def self.down
    drop_table :point_adjustments
  end
end

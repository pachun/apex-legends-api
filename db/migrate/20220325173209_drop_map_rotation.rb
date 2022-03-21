class DropMapRotation < ActiveRecord::Migration[7.0]
  def change
    drop_table :map_rotations
  end
end

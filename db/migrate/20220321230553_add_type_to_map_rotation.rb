class AddTypeToMapRotation < ActiveRecord::Migration[7.0]
  def change
    add_column :map_rotations, :type, :integer
  end
end

class RenameTypeAttribute < ActiveRecord::Migration[7.0]
  def change
    rename_column :map_rotations, :type, :map_rotation_type
  end
end

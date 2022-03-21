class EnforceUniqueMapTypes < ActiveRecord::Migration[7.0]
  def change
    add_index :apex_legends_maps, :map_type, unique: true
  end
end

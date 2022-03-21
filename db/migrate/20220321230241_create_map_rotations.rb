class CreateMapRotations < ActiveRecord::Migration[7.0]
  def change
    create_table :map_rotations do |t|
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end

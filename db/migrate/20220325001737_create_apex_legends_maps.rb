class CreateApexLegendsMaps < ActiveRecord::Migration[7.0]
  def change
    create_table :apex_legends_maps do |t|
      t.integer :map_type
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end

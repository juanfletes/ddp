class CreateActividades < ActiveRecord::Migration[5.1]
  def change
    create_table :actividades do |t|
      t.string :nombre, null: false, limit: 1000
      t.date :fecha, null: false
      t.string :objetivo, null: false, limit: 10000
      t.string :reporte, limit: 100000
      t.integer :tipo, null: false
      t.string :observacion, limit: 10000

      t.timestamps
    end
    add_index :actividades, :nombre, unique: true
  end
end

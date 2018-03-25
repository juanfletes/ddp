class CreateIntegranteActividades < ActiveRecord::Migration[5.1]
  def change
    create_table :integrante_actividades do |t|
      t.references :actividad, foreign_key: true, null: false
      t.references :matrimonio, foreign_key: true, null: false, index: false
      t.string :observacion

      t.timestamps
    end
    add_index :integrante_actividades, :matrimonio_id, unique: true
  end
end

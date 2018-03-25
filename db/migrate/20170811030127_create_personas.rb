class CreatePersonas < ActiveRecord::Migration[5.1]
  def change
    create_table :personas do |t|
      t.string :primer_nombre, null: false, limit: 100
      t.string :segundo_nombre, limit: 100
      t.string :primer_apellido, null: false, limit: 100
      t.string :segundo_apellido, limit: 100
      t.string :sexo, null: false, limit: 1
      t.date :fecha_nacimiento
      t.string :direccion
      t.boolean :bautizado, null: false, default: false
      t.date :fecha_bautismo
      t.boolean :epp, null: false, default: false
      t.date :fecha_epp
      t.boolean :edl, null: false, default: false
      t.date :fecha_edl
      t.string :observacion, limit: 10000

      t.timestamps
    end
  end
end

class CreateCirculoAmistades < ActiveRecord::Migration[5.1]
  def change
    create_table :circulo_amistades do |t|
      t.string :nombre, null: false, limit: 500
      t.string :direccion, null: false, limit: 1000
      t.string :horario, null: false, limit: 500
      t.boolean :pasivo, null: false, default: false

      t.timestamps
    end
    add_index :circulo_amistades, :nombre, unique: true
  end
end

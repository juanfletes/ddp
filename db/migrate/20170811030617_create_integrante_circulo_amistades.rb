class CreateIntegranteCirculoAmistades < ActiveRecord::Migration[5.1]
  def change
    create_table :integrante_circulo_amistades do |t|
      t.references :circulo_amistad, index: true, null: false
      t.references :persona, null: false, index: false
      t.integer :tipo, null: false

      t.timestamps
    end
    add_index :integrante_circulo_amistades, :persona_id, unique: true
    add_foreign_key :integrante_circulo_amistades, :circulo_amistades
    add_foreign_key :integrante_circulo_amistades, :personas
  end
end

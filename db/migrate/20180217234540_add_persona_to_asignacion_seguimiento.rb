class AddPersonaToAsignacionSeguimiento < ActiveRecord::Migration[5.1]
  def change
    add_reference :asignaciones_seguimiento, :persona, index: false, null: false, foreign_key: true
    add_index :asignaciones_seguimiento, :persona_id, unique: true
  end
end

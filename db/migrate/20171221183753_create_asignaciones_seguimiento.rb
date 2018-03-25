class CreateAsignacionesSeguimiento < ActiveRecord::Migration[5.1]

  def change
    create_table :asignaciones_seguimiento do |t|
      t.references :usuario, foreign_key: true, null: false
      t.references :matrimonio, foreign_key: true, null: false, index: false

      t.timestamps
    end
    add_index :asignaciones_seguimiento, :matrimonio_id, unique: true
  end

end

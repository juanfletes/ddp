class RemoveMatrimonioToAsignacionSeguimiento < ActiveRecord::Migration[5.1]
  def change
    remove_column :asignaciones_seguimiento, :matrimonio_id
  end
end

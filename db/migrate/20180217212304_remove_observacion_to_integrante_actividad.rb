class RemoveObservacionToIntegranteActividad < ActiveRecord::Migration[5.1]
  def change
    remove_column :integrante_actividades, :observacion
  end
end

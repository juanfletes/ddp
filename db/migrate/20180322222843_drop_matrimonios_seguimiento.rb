class DropMatrimoniosSeguimiento < ActiveRecord::Migration[5.1]
  def change
    drop_table :matrimonios_seguimiento
  end
end

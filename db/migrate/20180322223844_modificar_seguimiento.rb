class ModificarSeguimiento < ActiveRecord::Migration[5.1]
  def change
    add_column :personas, :seguimiento, :boolean, default: true
    remove_column :matrimonios, :seguimiento
  end
end

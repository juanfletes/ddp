class AddSeguimientoToMatrimonio < ActiveRecord::Migration[5.1]

  def change
    add_column :matrimonios, :seguimiento, :boolean, default: true
  end

end

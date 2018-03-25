class AddSexoToUsuario < ActiveRecord::Migration[5.1]
  def change
    add_column :usuarios, :sexo, :string, limit: 1
  end
end

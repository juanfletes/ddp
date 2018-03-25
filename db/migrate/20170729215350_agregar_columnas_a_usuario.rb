class AgregarColumnasAUsuario < ActiveRecord::Migration[5.1]
  def change
    add_column :usuarios, :username, :string, null: false, limit: 50
    add_column :usuarios, :primer_nombre, :string, null: false
    add_column :usuarios, :segundo_nombre, :string
    add_column :usuarios, :primer_apellido, :string, null: false
    add_column :usuarios, :segundo_apellido, :string

    add_index :usuarios, :username, unique: true
  end
end

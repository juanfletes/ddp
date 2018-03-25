class AddFKeyPersonaToUsuario < ActiveRecord::Migration[5.1]

  def change
    add_foreign_key :usuarios, :personas
  end

end

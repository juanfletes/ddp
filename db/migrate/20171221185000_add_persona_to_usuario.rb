class AddPersonaToUsuario < ActiveRecord::Migration[5.1]

  def change
    add_reference :usuarios, :persona, index: true, null: true
  end

end

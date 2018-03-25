class AddTelefonoToPersona < ActiveRecord::Migration[5.1]
  def change
    add_column :personas, :telefono, :string, limit: 10
  end
end

class AddCelularToPersona < ActiveRecord::Migration[5.1]

  def change
    add_column :personas, :celular, :string, limit: 10
  end

end

class AddEmailToPersona < ActiveRecord::Migration[5.1]

  def change
    add_column :personas, :email, :string, limit: 250
  end

end

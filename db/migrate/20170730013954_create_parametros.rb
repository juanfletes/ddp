class CreateParametros < ActiveRecord::Migration[5.1]
  def change
    create_table :parametros do |t|
      t.string :codigo, null: false, limit: 10
      t.string :nombre, null: false, limit: 1000
      t.string :valor, null: false, limit: 1000

      t.timestamps
    end
    add_index :parametros, :codigo, unique: true
    add_index :parametros, :nombre, unique: true
  end
end

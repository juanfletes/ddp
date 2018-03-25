class CreatePersonaNotaSeguimiento < ActiveRecord::Migration[5.1]
  def change
    create_table :personas_nota_seguimiento do |t|
      t.date :fecha, null: false
      t.references :persona, foreign_key: true, null: false
      t.references :usuario, foreign_key: true, null: false
      t.string :notas, null: false, limit: 10_000

      t.timestamps
    end
  end
end

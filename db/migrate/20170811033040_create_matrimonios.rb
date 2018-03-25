class CreateMatrimonios < ActiveRecord::Migration[5.1]
  def change
    create_table :matrimonios do |t|
      t.integer :esposo_id, null: false
      t.integer :esposa_id, null: false
      t.boolean :boda_civil, null: false, default: false
      t.date :fecha_civil
      t.boolean :boda_eclesiastica, null: false, default: false
      t.date :fecha_elesiastica
      t.boolean :ddp, null: false, default: false
      t.string :observacion, limit: 10000

      t.timestamps
    end
    add_index :matrimonios, :esposo_id, unique: true
    add_index :matrimonios, :esposa_id, unique: true
    add_foreign_key :matrimonios, :personas, column: :esposo_id
    add_foreign_key :matrimonios, :personas, column: :esposa_id
  end
end

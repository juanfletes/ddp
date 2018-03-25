class RemoveColumns < ActiveRecord::Migration[5.1]

  def change
    remove_column :matrimonios, :fecha_civil
    remove_column :matrimonios, :fecha_elesiastica
    remove_column :matrimonios, :ddp
    remove_column :personas, :fecha_bautismo
    remove_column :personas, :fecha_epp
    remove_column :personas, :fecha_edl
    remove_column :usuarios, :username
  end

end

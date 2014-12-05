class CreateTecnicos < ActiveRecord::Migration
  def change
    create_table :tecnicos do |t|
      t.string :nombre_tec
      t.string :apellido_pat_tec
      t.string :apellido_mat_tec
      t.decimal :rut_tec
      t.boolean :sexo_tec
      t.date :fecha_nac_tec
      t.string :email_tec
      t.string :foto_tec

      t.timestamps
    end
  end
end

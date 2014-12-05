class CreateJugadors < ActiveRecord::Migration
  def change
    create_table :jugadors do |t|
      t.string :nombre_jug
      t.string :apellido_pat_jug
      t.string :apellido_mat_jug
      t.decimal :rut_jug
      t.boolean :sexo_jug
      t.date :fecha_nac_jug
      t.string :email_jug
      t.string :foto_jug

      t.timestamps
    end
  end
end

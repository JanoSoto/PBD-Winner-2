class CreateJueces < ActiveRecord::Migration
  def change
    create_table :jueces do |t|
      t.string :nombre_juez
      t.string :apellido_pat_juez
      t.string :apellido_mat_juez
      t.decimal :rut_juez
      t.boolean :sexo_juez
      t.date :fecha_nac_juez
      t.string :email_juez
      t.string :foto_juez

      t.timestamps
    end
  end
end

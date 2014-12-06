class CreateConvocatoria < ActiveRecord::Migration
  def change
    create_table :convocatoria do |t|
      t.references :jugador, index: true
      t.references :participante, index: true
      t.date :fecha_con
      t.integer :duracion_con
      t.integer :num_camiseta_con

      t.timestamps
    end
  end
end

class CreateEncuentros < ActiveRecord::Migration
  def change
    create_table :encuentros do |t|
      t.datetime :fecha_enc
      t.integer :tiro_libre_local_enc
      t.integer :tiro_esquina_local_enc
      t.integer :fuera_de_juego_local_enc
      t.integer :tiro_libre_visita_enc
      t.integer :tiro_esquina_visita_enc
      t.integer :fuera_de_juego_visita_enc
      t.string :duracion_enc
      t.integer :cant_publico_enc
      t.integer :gol_local_enc
      t.integer :gol_visita_enc
      t.boolean :def_penales_enc
      t.string :estado_enc

      t.timestamps
    end
  end
end

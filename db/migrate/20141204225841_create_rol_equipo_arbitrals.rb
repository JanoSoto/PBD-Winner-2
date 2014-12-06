class CreateRolEquipoArbitrals < ActiveRecord::Migration
  def change
    create_table :rol_equipo_arbitrals do |t|
      t.references :rol_jueces, index: true
      t.references :jueces, index: true
      t.references :encuentros, index: true

      t.timestamps
    end
  end
end

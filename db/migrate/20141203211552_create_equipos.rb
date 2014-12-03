class CreateEquipos < ActiveRecord::Migration
  def change
    create_table :equipos do |t|
      t.references :encuentro, index: true
      t.references :convocatoria, index: true
      t.string :equ_citado

      t.timestamps
    end
  end
end

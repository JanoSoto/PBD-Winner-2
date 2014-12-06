class CreateRolJueces < ActiveRecord::Migration
  def change
    create_table :rol_jueces do |t|
      t.string :tipo_rol_juez

      t.timestamps
    end
  end
end

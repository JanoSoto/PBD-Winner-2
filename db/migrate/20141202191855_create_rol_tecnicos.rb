class CreateRolTecnicos < ActiveRecord::Migration
  def change
    create_table :rol_tecnicos do |t|
      t.string :tipo_rol_tec

      t.timestamps
    end
  end
end

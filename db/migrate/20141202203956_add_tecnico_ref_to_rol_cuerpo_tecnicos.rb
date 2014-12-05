class AddTecnicoRefToRolCuerpoTecnicos < ActiveRecord::Migration
  def change
    add_reference :rol_cuerpo_tecnicos, :tecnico, index: true
  end
end

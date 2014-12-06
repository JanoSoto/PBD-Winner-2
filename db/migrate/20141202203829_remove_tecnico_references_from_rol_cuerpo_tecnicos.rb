class RemoveTecnicoReferencesFromRolCuerpoTecnicos < ActiveRecord::Migration
  def change
    remove_column :rol_cuerpo_tecnicos, :tecnico_references, :string
  end
end

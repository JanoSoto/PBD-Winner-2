class CreateRolCuerpoTecnicos < ActiveRecord::Migration
  def change
    create_table :rol_cuerpo_tecnicos do |t|
      t.references :rol_tecnico, index: true
      t.references :participante_competencium, index: true
      t.string :tecnico_references

      t.timestamps
    end
  end
end

class CreateEtapas < ActiveRecord::Migration
  def change
    create_table :etapas do |t|
      t.string :nombre_etp
      t.integer :tipo_etp
      t.references :competencia, index: true
      t.references :etapa, index: true

      t.timestamps
    end
  end
end

class CreateParticipantes < ActiveRecord::Migration
  def change
    create_table :participantes do |t|
      t.string :nombre_par
      t.string :pais_par

      t.timestamps
    end
  end
end

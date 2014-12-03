class CreateParticipanteCompetencia < ActiveRecord::Migration
  def change
    create_table :participante_competencia do |t|
      t.references :competencia, index: true
      t.references :participante, index: true
      t.integer :enc_ganados_par_com
      t.integer :enc_perdidos_par_com
      t.integer :enc_perdidos_par_com
      t.integer :goles_favor_par_com
      t.integer :goles_contra_par_com
      t.integer :cant_tarjetas_amar_par_com
      t.integer :cant_tarjetas_roja_par_com
      t.integer :cant_puntos_par_com
      t.integer :cant_enc_jugados_par_com
      t.integer :grupo_par_com
      t.integer :total_enc_grupo_par_com

      t.timestamps
    end
  end
end

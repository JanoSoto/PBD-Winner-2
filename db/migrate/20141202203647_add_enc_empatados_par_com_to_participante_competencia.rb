class AddEncEmpatadosParComToParticipanteCompetencia < ActiveRecord::Migration
  def change
    add_column :participante_competencia, :enc_empatados_par_com, :integer
  end
end

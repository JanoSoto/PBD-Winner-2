class ParticipanteCompetencium < ActiveRecord::Base
  belongs_to :competencia
  belongs_to :participante
end

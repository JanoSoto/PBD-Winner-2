class Convocatoria < ActiveRecord::Base
  belongs_to :jugador
  belongs_to :participante
end

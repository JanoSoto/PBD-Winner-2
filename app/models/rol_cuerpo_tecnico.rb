class RolCuerpoTecnico < ActiveRecord::Base
  belongs_to :rol_tecnico
  belongs_to :participante_competencium
end

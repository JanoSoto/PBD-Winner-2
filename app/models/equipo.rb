class Equipo < ActiveRecord::Base
  belongs_to :encuentro
  belongs_to :convocatoria
end

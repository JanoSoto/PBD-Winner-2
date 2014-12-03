class Etapa < ActiveRecord::Base
  belongs_to :competencia
  belongs_to :etapa
end

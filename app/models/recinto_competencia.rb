class RecintoCompetencia < ActiveRecord::Base
  belongs_to :recinto
  belongs_to :competencia
end

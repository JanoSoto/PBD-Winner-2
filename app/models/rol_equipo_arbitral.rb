class RolEquipoArbitral < ActiveRecord::Base
  belongs_to :rol_jueces
  belongs_to :jueces
  belongs_to :encuentros
end

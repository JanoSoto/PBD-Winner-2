class AddRefToEncuentros < ActiveRecord::Migration
  def change
    add_reference :encuentros, :etapa, index: true
    add_reference :encuentros, :competencia, index: true
    add_reference :encuentros, :recinto, index: true
  end
end

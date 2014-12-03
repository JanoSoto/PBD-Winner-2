class AddParticipantesToEncuentros < ActiveRecord::Migration
  def change
    add_column :encuentros, :id_local, :integer, index: true
    add_column :encuentros, :id_visita, :integer, index: true
  end
end

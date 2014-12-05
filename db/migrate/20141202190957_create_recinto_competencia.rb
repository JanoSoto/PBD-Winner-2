class CreateRecintoCompetencia < ActiveRecord::Migration
  def change
    create_table :recinto_competencia do |t|
      t.references :recinto, index: true
      t.references :competencia, index: true

      t.timestamps
    end
  end
end

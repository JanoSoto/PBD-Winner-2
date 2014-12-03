class CreateRecintos < ActiveRecord::Migration
  def change
    create_table :recintos do |t|
      t.string :nombre_rec
      t.string :ciudad_rec
      t.string :pais_rec
      t.integer :capacidad_rec

      t.timestamps
    end
  end
end

class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :titulo
      t.text :cuerpo
      t.integer :nmro_visitas

      t.timestamps
    end
  end
end

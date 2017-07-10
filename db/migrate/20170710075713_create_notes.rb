class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :description
      t.integer :privacy
      t.boolean :featured
      t.string :cover_image

      t.timestamps
    end
  end
end

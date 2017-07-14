class CreateEncouragements < ActiveRecord::Migration[5.1]
  def change
    create_table :encouragements do |t|
      t.integer :user_id, index: true
      t.integer :note_id, index: true
      t.string :message
      t.timestamps
    end
  end
end

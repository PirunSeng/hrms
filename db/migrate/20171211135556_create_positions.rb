class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.string :title, default: ''
      t.text :description, default: ''

      t.timestamps
    end
  end
end

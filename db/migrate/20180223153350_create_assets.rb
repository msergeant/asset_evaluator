class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets do |t|
      t.string :name
      t.string :grade
      t.string :evaluation

      t.timestamps
    end
  end
end

class CreateThematics < ActiveRecord::Migration[6.0]
  def change
    create_table :thematics do |t|
      t.string :name

      t.timestamps
    end
  end
end

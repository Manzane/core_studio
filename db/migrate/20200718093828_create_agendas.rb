class CreateAgendas < ActiveRecord::Migration[6.0]
  def change
    create_table :agendas do |t|
      t.datetime :time
      t.integer :capacity
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end

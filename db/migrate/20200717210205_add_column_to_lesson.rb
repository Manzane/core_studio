class AddColumnToLesson < ActiveRecord::Migration[6.0]
  def change
    add_reference :lessons, :thematic, null: false, foreign_key: true
  end
end

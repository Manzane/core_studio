class AddColumnsToLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :start_lesson, :datetime
    add_column :lessons, :end_lesson, :datetime
    add_column :lessons, :capacity, :integer
  end
end

class RenameColumnsFromLessons < ActiveRecord::Migration[6.0]
  def change
    rename_column :lessons, :start_lesson, :start_time
    rename_column :lessons, :end_lesson, :end_time
  end
end

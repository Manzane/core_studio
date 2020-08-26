class AddDefaultEndDateToLessons < ActiveRecord::Migration[6.0]
  def change
    change_column :lessons, :end_date, :datetime, default: Time.now
  end
end

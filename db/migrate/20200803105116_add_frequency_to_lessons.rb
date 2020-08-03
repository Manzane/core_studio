class AddFrequencyToLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :frequency_day, :integer
    add_column :lessons, :end_date, :datetime
  end
end

class AddDefaultValueToLessons < ActiveRecord::Migration[6.0]
  def change
    change_column :lessons, :color, :string, :default => "white"
  end
end

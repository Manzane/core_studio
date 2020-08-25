class AddColorToLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :color, :string
  end
end

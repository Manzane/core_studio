class AddPublishedToThematics < ActiveRecord::Migration[6.0]
  def change
    add_column :thematics, :published, :boolean, default: true
  end
end

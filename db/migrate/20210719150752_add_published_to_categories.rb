class AddPublishedToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :published, :boolean, default: true
  end
end

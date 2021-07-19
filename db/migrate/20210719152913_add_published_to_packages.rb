class AddPublishedToPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :packages, :published, :boolean, default: true
  end
end

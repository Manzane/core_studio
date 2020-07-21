class ChangeColumnNameDateInAgenda < ActiveRecord::Migration[6.0]
  def change
    rename_column :agendas, :time, :start
    add_column :agendas, :end, :datetime
  end
end

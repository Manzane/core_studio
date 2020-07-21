class RemoveTableAgenda < ActiveRecord::Migration[6.0]
  def change
    drop_table :agendas
  end
end

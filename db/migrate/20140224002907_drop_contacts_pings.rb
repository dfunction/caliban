class DropContactsPings < ActiveRecord::Migration
  def change
    drop_table :contacts_pings
  end
end

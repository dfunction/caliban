class CreateContactpingTable < ActiveRecord::Migration
  def change
    create_table :contactpings do |t|
      t.belongs_to :contact
      t.belongs_to :ping
      t.timestamps
    end
  end
end

class AttendEvents < ActiveRecord::Migration[5.1]
  def change
  	create_table :event_attends do |t|
			t.belongs_to	:user
			t.belongs_to	:event
		  t.timestamps
		end
  end
end

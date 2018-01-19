class AddFollowers < ActiveRecord::Migration[5.1]
  def change
  	create_table :follows do |t|
			t.belongs_to	:follower#, foreign_key: "follower_id", class_name: "User"
			t.belongs_to	:followtarget#, foreign_key: "followtarget_id", class_name: "User"
		  t.timestamps
		end
  end
end

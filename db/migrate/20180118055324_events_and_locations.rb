class EventsAndLocations < ActiveRecord::Migration[5.1]
  def change
  	create_table :events do |t|
  	  t.integer	:expected
  	  t.integer	:food_amount
  	  t.belongs_to	:user
  	  t.belongs_to	:location
  	  t.date	:date
  	  t.time 	:start_time
  	  t.time 	:end_time
  	  t.timestamps
  	end

  	create_table :locations do |t|
  	  t.string :name
  	  t.string :address
  	  #Add coordinates later when map APIs are implemented

  	  t.timestamps
  	end
  end
end

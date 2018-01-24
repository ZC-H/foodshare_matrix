class Event < ApplicationRecord
	include Filterable
	belongs_to	:user
	belongs_to	:location
	scope :date, -> (date) { where date: date }
	scope :from_date, -> (from_date) { where "date >= ?", from_date.to_date }
	scope :to_date, -> (to_date) { where "date <= ?", to_date.to_date }
	
	has_many :event_attends
  has_many :attenders, through: :event_attends, source: :user
  
end

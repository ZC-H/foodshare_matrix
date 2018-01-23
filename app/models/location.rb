class Location < ApplicationRecord
	has_many	:events
	geocoded_by :address
	reverse_geocoded_by :latitude, :longitude

	after_validation :reverse_geocode, if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }
	after_validation :geocode, unless: ->(obj) { obj.latitude.present? and obj.longitude.present? }, if: ->(obj){ obj.address.present? and obj.address_changed? }


	def score
		locscore = self.events.length
		self.nearbys(1).each do |loc|
			locscore += loc.events.length
		end
		locscore
	end

	def check_duplicate
		Location.all.each do |loc|
			return loc.id if ( self.longitude == loc.longitude && self.latitude == loc.latitude && self.id != loc.id)
		end
		return false
	end

	def events_within(distance,days=0,start_date=Date.today)
		evs = []
		evs += self.events
		near = self.nearbys(distance)
		near.each { |nearloc| evs += nearloc.events } #make array of all nearby events
		evs_within = []
		evs.each do |ev|
			evs_within << ev if (ev.date >= start_date && ev.date <= start_date + days )
		end
		evs_within
	end

end

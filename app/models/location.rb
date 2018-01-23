class Location < ApplicationRecord
	has_many	:events
	geocoded_by :address
	reverse_geocoded_by :latitude, :longitude

	after_validation :reverse_geocode, if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }
	after_validation :geocode, unless: ->(obj) { obj.latitude.present? and obj.longitude.present? }, if: ->(obj){ obj.address.present? and obj.address_changed? }


	def score
		#Enhance this method later
		self.nearbys(1).length
	end

	def check_duplicate
		Location.all.each do |loc|
			return loc.id if ( self.longitude == loc.longitude && self.latitude == loc.latitude )
		end
		return false
	end
end

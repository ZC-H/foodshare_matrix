class LocationsController < ApplicationController
	before_action	:find_location, only: [:show, :edit, :update]
	def find_location
		@location = Location.find_by_id(params[:id])
		if !@location
			#Put a real error page here later
			redirect_to '/'
		end
	end

	def show
	end

	def index
    @locations = Location.all.sort_by(&:score).reverse
	end

	def new
		@location = Location.new
	end

	def create
    @location = Location.new(location_params)
    if @location.valid?
    	@locjson = @location.to_json
    	@event = Event.new
    	@event.date = params[:date].to_date
      @nearbyevents = @location.events_within(1)
    	render 'events/new'
      #flash[:success] = "Place added!"
      #redirect_to '/'
    else
      render 'new'
      #Change this to it displays any error messages on the page
    end
  end

  private

    def location_params
      params.require(:location).permit(:name, :address, :longitude, :latitude)
    end
end
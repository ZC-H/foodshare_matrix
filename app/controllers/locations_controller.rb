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

	def new
		@location = Location.new
	end

	def create
    @location = Location.new(location_params)
    if @location.save
      flash[:success] = "Place added!"
      redirect_to '/'
    else
      render 'new'
    end
  end

  private

    def location_params
      params.require(:location).permit(:name, :address)
    end
end
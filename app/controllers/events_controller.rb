class EventsController < ApplicationController
	before_action	:find_event, only: [:show, :edit, :update, :destroy]
	def find_event
		@event = Event.find_by_id(params[:id])
		if !@event
			#Put a real error page here later
			redirect_to '/'
		end
	end

	def index
		@filtered = Event.filter(params.slice(:date, :user, :from_date, :to_date))
		@events = @filtered
		if params[:latitude] && params[:longitude]
			loc = Location.new(latitude: params[:latitude][0].to_f, longitude: params[:longitude][0].to_f)
			p loc
			nearvents = loc.events_within_timeless(params[:radius][0].to_f)
			p nearvents
			p @events
			@events = @events & nearvents
		end		
	end

	#def new
	#	@event = Event.new
	#end

	def create
		@event = current_user.events.new(event_params)
		@event.location_id = Location.first.id #Have to temporarily hardcode in a location ID to check if it's valid before we save the associated location
		if @event.valid?
			@location = Location.new(JSON.parse params[:event][:location])
			dupl = @location.check_duplicate #dupl returns an integer if location exists
			@event.location = nil
			if dupl #if location already exists
				@event.location_id = dupl
			else
				@location.save
				@event.location_id = @location.id
			end
			@event.save
		  redirect_to @event
		else
		  render 'new'
		  #Flash errors here
		end
		#Also need to add a method to Location to merge identical points		
	end

	def show
	end

	def edit
	end

	def update
		if @event.update_attributes(event_params)
      redirect_to @event
    else
    	flash[:danger] = "Error updating event"
      render 'edit'
    end
	end


	def destroy
		@event.destroy
		redirect_to events_url

	end


	def search_page
		render 'events/search'
	end



	private
	def event_params
	  params.require(:event).permit(:name, :description, :expected, :food_amount, :date, :location_id)
	end
end

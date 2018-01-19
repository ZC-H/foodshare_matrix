class EventsController < ApplicationController
	before_action	:find_event, only: [:show, :edit, :update]
	def find_event
		@event = Event.find_by_id(params[:id])
		if !@event
			#Put a real error page here later
			redirect_to '/'
		end
	end

	def index
	end

	def new
		@event = Event.new
	end

	def create
		@event = current_user.events.new(event_params)
		@event.location_id = 1 #Edit this later
		if @event.save
		  redirect_to @event
		else
		  render 'new'

		  #Flash errors here
		end
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

	private
	def event_params
	  params.require(:event).permit(:name, :description, :expected, :food_amount)
	end

end

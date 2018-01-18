class EventsController < ApplicationController
	before_action	:find_event, only: [:show, :edit, :update]
	def find_event
		@event = Event.find(params[:id])
	end

	def index
	end

	def new
		@event = Event.new
	end

	def create
		@event = current_user.events.new(event_params)
		@event.location_id = 1 #Edit this later
		p "ccccccccccc"
		p @event
		if @event.save
		  redirect_to @event
		else
			p "aaaaaaaaaaaaaaaa"
			p @errors
		  render 'new'

		  #Flash errors here
		end
	end

	def show
	end

	def edit
	end

	def update
	end

	private
	def event_params
	  params.require(:event).permit(:name, :description, :expected, :food_amount)
	end

end

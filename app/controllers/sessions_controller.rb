class SessionsController < Clearance::SessionsController

	def new
		@user = User.new
	end


	def create
	  @user = authenticate(params)

	  sign_in(@user) do |status|
	    if status.success?
	      redirect_back_or url_after_create
	    else
	      flash.now.notice = status.failure_message
	      @user = User.new #Patch fix, there should be a better way to do this
	      #Probably change render to redirect or something
	      render template: "sessions/new", status: :unauthorized
	    end
	  end
	end


end
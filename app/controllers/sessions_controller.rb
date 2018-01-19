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
	      redirect '/sign_in', status: :unauthorized
	    end
	  end
	end


end
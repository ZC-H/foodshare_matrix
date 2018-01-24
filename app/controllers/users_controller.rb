class UsersController < Clearance::UsersController


	def index
		@user = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome"
			redirect_to root_url
		else 
			flash[:danger] = @user.errors.full_messages.first
			
			redirect_to sign_up_path
			
		end
	end

	


	def show
		@user = User.find(params[:id])
		@events = @user.events.order("updated_at DESC")

		
		render 'users/show'
	end


	def edit
		@user = User.find(params[:id])
	end


	def update
		@user = User.find(params[:id])
		@user.update_attributes(user_params)
		redirect_to root_url
	end 

	#The below methods were originally written for sinatra, may need some changing
	def follow
		user = User.find_by_id(params[:id])
		if !user or user == current_user
			return "Error: Invalid user ID, or you tried to follow yourself"
		end
		if current_user.followtargets.include?(user)
			return "You are already following this user."
		end
		current_user.followtarget_joins.create({followtarget_id: params[:id]})
		#Need to refresh page
	end

	def unfollow
		user = User.find_by_id(params[:id])
		if !user or !current_user.followtargets.include?(user)
			return "Error: Invalid user ID, or you are not following that user."
		end
		join = current_user.followtarget_joins.find_by(followtarget_id: params[:id])
		join.delete

	end

	private

  def user_params
		params.require(:user).permit(:name, :email, :password, :role)
	end







end
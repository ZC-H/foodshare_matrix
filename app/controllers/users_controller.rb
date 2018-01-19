class UsersController < Clearance::UsersController


	def index
		@user = User.all
	end

	def new
		@user = User.new
		render 'users/new'
	end

	def create
		@user = User.new(user_from_params)

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
		
		render 'users/show'
	end


	def edit
		@user = User.find(params[:id])
	end


	def update
		@user = User.find(params[:id])
		@user.update_attributes(user_from_params)
		redirect_to @user
	end 



    def user_from_params
		params.require(:user).permit(:name, :email, :password,:optradio)
	end







end
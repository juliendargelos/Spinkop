class UsersController < ApplicationController
	before_filter :authorize, only: [:index, :new, :edit, :create, :update, :destroy]
	before_action :set_user, only: [:edit, :update, :destroy]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		user = User.new user_params
		if user.save
			redirect_to action: :index
		else
			redirect_to new_user_path
		end
	end

	def edit
	end

	def update
	    @user.update(user_params)
		redirect_to action: :edit, id: @user.id
	end

	def destroy
		@user.destroy
		redirect_to action: :index
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

	def set_user
		@user = User.find(params[:id])
	end
end

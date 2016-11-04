class UsersController < ApplicationController
	before_action :authorize, only: [:index, :new, :edit, :create, :update, :destroy]
	before_action :set_user, only: [:edit, :update, :destroy]
	before_action :require_admin, only: [:new, :create]
	before_action :require_self_user, only: [:update, :edit, :destroy]

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
		redirect_to action: :index
	end

	def destroy
		@user.destroy
		redirect_to action: :index
	end

	def self_user?
		(current_user && current_user.id == @user.id) || is_admin?
	end
	helper_method :self_user?

	private

		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end

		def require_admin
			redirect_to action: :index unless is_admin?
		end

		def require_self_user
			redirect_to action: :index unless self_user?
		end

		def set_user
			@user = User.find(params[:id])
		end
end

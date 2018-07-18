class UsersController < ApplicationController
	before_action :require_owner, only: [:edit, :update]

	def index
		@users = User.all
	end

	def new
		if current_user == nil || current_user.admin?
			@user = User.new
		else
			redirect_to root_path
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			starting_balance(@user)
			redirect_to login_path, :flash => { :success => "User successfully created" }
		else
			redirect_to new_user_path, :flash => { :error => "Failed to create users" }
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

    	if @user.update(user_params)
    		redirect_to user_path(@user.id), :flash => { :success => "User successfully updated" }
    	else	
			render 'edit', :flash => { :error => "Failed to update user" }
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to users_path, :flash => { :success => "User successfully destroyed" }
		else
			redirect_to user_path(@user.id), :flash => { :success => "Failed to delete user" }
		end
	end

	def show
		@user = User.find(params[:id])
		@balances = @user.balances
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end

	def require_owner
		unless current_user == User.find(params[:id]) || current_user.admin?
			redirect_to users_path, :flash => { :error => "You do not have permission to view this page" }	
		end
	end
end

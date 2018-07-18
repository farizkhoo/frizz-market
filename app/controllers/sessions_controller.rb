class SessionsController < ApplicationController
	def new
		if current_user != nil
			redirect_to root_path
		end
	end

	def create
		user = User.find_by(username: params[:login][:username])
		if user && user.authenticate(params[:login][:password])
			session[:user_id] = user.id.to_s
			redirect_to '/', :flash => { :success => "Successfully logged in!" }
		else
			render :new, :flash => { :error => "Invalid username/password" }
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/', :flash => { :notice => "Logged out!" }
	end
end


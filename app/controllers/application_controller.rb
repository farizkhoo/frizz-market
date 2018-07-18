class ApplicationController < ActionController::Base

	def starting_balance(user)
		user_balance = user.balances.new(currency: 'MYR', amount: 0)
		user_balance.save
		user_balance = user.balances.new(currency: 'SGD', amount: 0)
		user_balance.save
		user_balance = user.balances.new(currency: 'USD', amount: 0)
		user_balance.save
		user_balance = user.balances.new(currency: 'GBP', amount: 0)
		user_balance.save
		user_balance = user.balances.new(currency: 'AUD', amount: 0)
		user_balance.save
	end



	private
	
	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user
end

class BraintreeController < ApplicationController
	def new
		@user = current_user
		@currency = params[:currency]
  		@client_token = Braintree::ClientToken.generate
  	end

  	def checkout
  		@currency = params[:deposit][:currency]
  		@amount = params[:deposit][:amount]
		nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

		result = Braintree::Transaction.sale(
			:amount => @amount, #this is currently hardcoded
			:payment_method_nonce => nonce_from_the_client,
			:options => {
			:submit_for_settlement => true
			}
		)

		if result.success?
			@user = current_user
			@deposit = @user.deposits.new(deposit_params)
			if @deposit.save
				@balance = @user.balances.find_by(currency: @currency)
				new_balance = @balance.amount + @amount.to_f
				@balance.update(amount: new_balance)
				redirect_to user_path(current_user), :flash => { :success => "Succesfully deposited #{@amount} #{@currency}" }
			else
				redirect_to root_path, :flash => { :error => "Critical error, contact admin" }
			end
		else
			redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
		end
	end

	private
	def deposit_params
		params.require(:deposit).permit(:currency, :amount)
	end
end

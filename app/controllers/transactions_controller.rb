class TransactionsController < ApplicationController
  def new
  	@order = Order.find(params[:id])
  	@transaction = Transaction.new
  end

  def create
  	@order = Order.find(params[:order_id])
  	@transaction = Transaction.new(transaction_params)
  	if @transaction.save
  		balance = current_user.balances.find_by(currency: @transaction.sell_currency)
  		new_balance = balance.amount + @transaction.sell_amount.to_f
  		balance.update(amount: new_balance)

  		balance = current_user.balances.find_by(currency: @transaction.buy_currency)
  		new_balance = balance.amount - @transaction.buy_amount.to_f
  		balance.update(amount: new_balance)
  		
  		buyer = User.find(@transaction.buyer_id)

  		buyer_balance = buyer.balances.find_by(currency: @transaction.sell_currency)
  		new_buyer_balance = buyer_balance.amount - @transaction.sell_amount.to_f
  		buyer_balance.update(amount: new_buyer_balance)

  		buyer_balance = buyer.balances.find_by(currency: @transaction.buy_currency)
  		new_buyer_balance = buyer_balance.amount + @transaction.buy_amount.to_f
  		buyer_balance.update(amount: new_buyer_balance)

  		@order.completed = true
  		@order.save
  		
  		redirect_to orders_path, :flash => { :success => "Transaction successful!"}
  	else
  		redirect_to orders_path, :flash => { :error => "Transaction failed!" }
  	end
  	

  end
  
  private
  def transaction_params
  	params.require(:transaction).permit(:buyer_id, :seller_id, :buy_currency, :buy_amount, :sell_currency, :sell_amount)
  end  
end

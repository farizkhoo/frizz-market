class OrdersController < ApplicationController
	def new
		@order = Order.new
		@user = User.find(params[:user_id])
		@user_balances = @user.balances
	end

	def create
		@order = current_user.orders.new(order_params)
		if @order.save
			balance = current_user.balances.find_by(currency: @order.sell_currency)
			new_balance = balance.amount - @order.sell_amount.to_f
			balance.update(amount: new_balance)
			redirect_to user_path(current_user), :flash => { :success => "Order successfully created!" }
		else
			flash[:error] = "An error has occured"
			render "new"
		end
	end

	def index
		if current_user
			@user = current_user
			@balances = @user.balances
		end

		if params[:term] != "" && params[:term] != nil
			@orders = []
			Order.where(completed: false).where.not(user_id: current_user.id).search(params[:term],"buy").each { |o| @orders << o }
			Order.where(completed: false).where.not(user_id: current_user.id).search(params[:term],"sell").each { |o| @orders << o }
		else
			if current_user
				@orders = Order.all.where(completed: false).where.not(user_id: current_user.id)
			else
				@orders = Order.all.where(completed: false)
			end
		end
	end

	def show
		@order = Order.find(params[:id])
	end

	# def buy_orders
	# 	@orders = Order.where(order_type: 0)
	# end

	# def sell_orders
	# 	@orders = Order.where(order_type: 1)
	# end

	private
	def order_params
		params.require(:order).permit(:buy_currency, :buy_amount, :sell_currency, :sell_amount, :order_type, :term)
	end
end

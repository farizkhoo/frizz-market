class OrdersController < ApplicationController
	def new
		@order = Order.new
		@user = User.find(params[:user_id])
		@user_balances = @user.balances
	end

	def create
		@order = current_user.orders.new(order_params)
		if @order.save
			redirect_to user_path(current_user), :flash => { :success => "Order successfully created!" }
		else
			flash[:error] = "An error has occured"
			render "new"
		end
	end

	def index
		if params[:term] != "" && params[:term] != nil
			@orders = []
			Order.search(params[:term],"buy").each { |o| @orders << o }
			Order.search(params[:term],"sell").each { |o| @orders << o }
		else
			@orders = Order.all
		end
	end

	def buy_orders
		@orders = Order.where(order_type: 0)
	end

	def sell_orders
		@orders = Order.where(order_type: 1)
	end

	private
	def order_params
		params.require(:order).permit(:buy_currency, :buy_amount, :sell_currency, :sell_amount, :order_type, :term)
	end
end

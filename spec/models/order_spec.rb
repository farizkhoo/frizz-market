require 'rails_helper'

# RSpec.describe Order, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe Order do
	let(:user)			{ User.new(username: "fariz", email: "fariz@fariz.com", password: "fariz", password_confirmation: "fariz") }
	let(:buy_amount)	{ 100 }
	let(:buy_currency)	{ "USD" }
	let(:sell_amount)	{ 400 }
	let(:sell_currency)	{ "MYR" }
	let(:order)			{ Order.new(user_id: user.id, buy_amount: buy_amount, buy_currency: buy_currency, sell_amount: sell_amount, sell_currency: sell_currency, order_type: 0) }
	let(:wrong_order)	{ Order.new(user_id: user.id, buy_amount: buy_amount, buy_currency: buy_currency, sell_amount: sell_amount, sell_currency: buy_currency, order_type: 0) }


	describe "buy_amount" do
		it { should validate_presence_of(:buy_amount) }
		it { should validate_numericality_of(:buy_amount) }
		it 'should return buy_amount' do
			expect(order.buy_amount).to eq(buy_amount)
		end
	end

	describe "sell_amount" do
		it { should validate_presence_of(:sell_amount) }
		it { should validate_numericality_of(:sell_amount) }
		it 'should return sell_amount' do
			expect(order.sell_amount).to eq(sell_amount)
		end
	end

	describe "buy_currency" do
		it 'should return buy_currency' do
			expect(order.buy_currency).to eq(buy_currency)
		end
	end

	describe "sell_currency" do
		it 'should return sell_currency' do
			expect(order.sell_currency).to eq(sell_currency)
		end
	end

	describe "checks for different currency" do
		context "saving orders" do
			it "should fail to save if same currency" do
				expect(wrong_order).to_not be_valid
			end

			it "should save if different currency" do
				expect(order).to be_a_kind_of(Order)
			end
		end
	end
end

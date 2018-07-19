require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe User do
	let(:username)	{ "fariz" }
	let(:email)		{ "fariz@fariz.com" }
	let(:password)	{ "fariz" }
	let(:user) 		{ User.new(username: username, email: email, password: password, password_confirmation: password)}
	let(:balance)	{ Balance.find_by(user_id: user.id) }
	let(:order)		{ Order.find_by(user_id: user.id) }
	let(:deposit)	{ Deposit.find_by(user_id: user.id) }

	describe '#username' do
		it { should validate_presence_of(:username) }
		it { should validate_uniqueness_of(:username) }
		it 'returns username of the user' do
			expect(user.username).to eq(username)
		end
	end

	describe '#email' do
		it { should validate_presence_of(:email) }
		it { should validate_uniqueness_of(:email) }
		it 'returns email of the user' do
			expect(user.email).to eq(email)
		end
	end

	describe 'has many associations' do
		context 'orders associations' do
			it { should have_many(:orders) }
			it 'returns first order of user' do
				expect(user.orders.first).to eq(order)
			end
		end

		context 'balance associations' do
			it { should have_many(:balances) }
			it 'returns first balance of user' do
				expect(user.balances.first).to eq(balance)
			end
		end

		context 'deposit associations' do
			it { should have_many(:deposits) }
			it 'returns first deposit of user' do
				expect(user.deposits.first).to eq(order)
			end
		end

	end

	describe 'has secure password' do
		it { should have_secure_password }
	end
end
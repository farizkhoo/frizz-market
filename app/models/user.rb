class User < ApplicationRecord
	has_secure_password
	has_many :orders, dependent: :destroy
	has_many :balances, dependent: :destroy
	has_many :deposits, dependent: :destroy
	enum role: [:user, :admin]

	validates :username, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true
end

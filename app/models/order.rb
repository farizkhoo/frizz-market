class Order < ApplicationRecord
  belongs_to :user
  validates :buy_amount, presence: true, numericality: { greater_than: 0}
  validates :sell_amount, presence: true, numericality: { greater_than: 0}
  validate :check_currency_type

  def check_currency_type
  	errors.add(:sell_currency, "can't be the same as buy currency") if buy_currency == sell_currency
  end

  def self.search(term,type)
  	if term && type == "buy"
  		where('buy_currency LIKE ?', "%#{term.upcase}%")
  	elsif term && type == "sell"
  		where('sell_currency LIKE ?', "%#{term.upcase}")
  	else
  		all
  	end
  end
end

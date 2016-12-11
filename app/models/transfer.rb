class Transfer < ApplicationRecord
  belongs_to :user

  validates :account_number_from, presence: true, length: { is: 18 }
  validates :account_number_to, presence: true, length: { is: 18 }
  validates :amount_penies, numericality: { only_integer: true, greater_than: 0 }
  validates :country_code_from, presence: true, length: { is: 3 }
  validates :country_code_to, presence: true, length: { is: 3 }
end

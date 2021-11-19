class Order < ApplicationRecord
  belongs_to :user

  enum pay_type: {
    "ATM": "A",
    "Credit Card": "C"
  }
end

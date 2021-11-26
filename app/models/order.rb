class Order < ApplicationRecord
  belongs_to :user
  
  validates :username, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :order_no, uniqueness: true 
  
  before_validation :build_order_no, on: :create

  enum pay_type: {
    "ATM": "A",
    "Credit Card": "C"
  }
  
  private 
  def build_order_no
    now = Date.current
    self.order_no = "RB#{now.strftime('%Y%m%d')}#{[*'A'..'Z', *'0'..'9'].sample(10).join}"
  end
end

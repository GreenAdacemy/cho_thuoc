# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  counter    :integer          default(0)
#  status     :integer          default("in_cart")
#  subtotal   :float            default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          default(0)
#
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: [:in_cart, :to_confirm, :confirmed, :to_ship, :shipping, :shipped, :completed, :cancled, :refunded]
  
  accepts_nested_attributes_for :order_items, allow_destroy: true

  def update_counter
    update(counter: self.order_items.sum(:quantity))
  end

  def update_subtotal
    update(subtotal: self.order_items.sum('price * quantity'))
  end

  def total
    sum = 0
    order_items.each do |i|
      sum += i.quantity * i.price * (1 - (i.product.event&.discount || 0))
    end
    sum.to_i
  end
  
  def items
    self.order_items.order(created_at: :desc)
  end

end

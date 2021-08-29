require Rails.root.join('app/helpers/application_helper')
include ApplicationHelper

namespace :cart do
  desc 'Create sample data user cart'
  task init: :environment do
    json = Rails.root.join('db/sample/carts.json')
    fetch_data(json).each_with_index do |item, index|
      user = User.find_by(id: item['userId'])
      show_data(user, data(item['products'])) unless user.nil?
    end
  end

  private
  def data(products)
    order = {
      status: Order::statuses[:in_cart],
      order_items_attributes: []
    }
    products.each do |product_info|
      product = Product.find_by(id: product_info['productId'])
      order[:order_items_attributes] << {
        product_id: product.id,
        price: product.price,
        quantity: product_info['quantity']
      }
    end
    order
  end

  def show_data(user, order)
    puts "add order for user #{user.email}"
    user.orders.create(order)
  end
end

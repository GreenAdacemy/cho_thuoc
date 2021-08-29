require Rails.root.join('app/helpers/application_helper')
include ApplicationHelper

namespace :cart do
  desc 'Create sample data user cart'
  task init: :environment do
    json = Rails.root.join('db/sample/carts.json')
    fetch_data(json).each_with_index do |item, index|
      puts item
      puts DateTime.parse(item['date'])
      item['products'].each do |product|
        puts product
        puts Product.find_by(id: product['productId'])&.price
      end
      puts User.find_by(id: item['userId'])&.email
      puts '-'*30
    end
  end
end

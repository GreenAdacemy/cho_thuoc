require Rails.root.join('app/helpers/application_helper')
include ApplicationHelper

namespace :user do
  desc 'Create sample data user'
  task init: :environment do
    json_file = Rails.root.join('db/sample/users.json')
    fetch_data(json_file).each_with_index do |item, index|
      puts "Generating user have email #{item['email']}"
      User.create json_data(item)
    end
  end

  private
  def json_data(data)
    {
      email: data['email'],
      password: '12345678',
      password_confirmation: '12345678',
      profile_attributes: {
        first_name: data['name']['firstname'],
        last_name: data['name']['lastname'],
        phone: data['phone'],
        address: {
          street: data['address']['street'],
          city: data['address']['city'],
          ref: data['address']['number'],
          zipcode: data['address']['zipcode']
        }
      }
    }
  end
end

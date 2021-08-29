require Rails.root.join('app/helpers/application_helper')
include ApplicationHelper

namespace :user do
  desc 'Create sample data user'
  task init: :environment do
    fetch_data.each_with_index do |item, index|
      puts item
    end
  end

  private
  def json_file
    Rails.root.join('db/sample/users.json')
  end
end

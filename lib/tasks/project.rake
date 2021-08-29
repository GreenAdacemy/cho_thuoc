namespace :project do
  desc 'call and generater sample data for project'
  task sample: :environment do
    Rake::Task['admin:init'].invoke
    Rake::Task['slide:init'].invoke
    Rake::Task['product:init'].invoke
    Rake::Task['user:init'].invoke
  end
end

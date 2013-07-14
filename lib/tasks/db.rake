# encoding: UTF-8
namespace :db do
  desc "Drop, create and migrate"
  task :rebuild => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    
    Rake::Task["db:seed"].invoke
  end
end

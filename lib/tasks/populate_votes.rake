namespace :db do
  namespace :seed do
    desc "Generate 10000 votes totally randomely"
    task :populate_votes => :environment do
      require "#{Rails.root}/db/seeds/votes.rb"
    end
  end
end
# encoding: UTF-8
namespace :db do
  namespace :log do
    desc "Runs daily, records ballot counts for every poll"
    task :polling => :environment do
      date = Time.now.utc.to_date.to_s(:db)
      
      Poll.all.each do |p|
        r = p.results.build(:yes_count => p.ballots.yes.size, :no_count => p.ballots.no.size, :date => date, :country_code => p.country_code)
        
        r.save if r.valid?
      end
    end
  end
end
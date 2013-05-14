# encoding: UTF-8
namespace :db do
  namespace :log do
    desc "Runs daily, records ballot counts for every poll"
    task :polling => :environment do
      date = Time.now.utc.to_date.to_s(:db)
      
      Poll.all.each do |p|
        n = p.polling_numbers.build(:yes_count => p.yes.size, :no_count => p.no.size, :date => date, :country_code => p.country_code)
        
        n.save if n.valid?
      end
    end
  end
end
# encoding: UTF-8
namespace :db do
  namespace :seed do
    desc "Load askable seed data for developement and test"
    task :askables => :environment do
      #Polls
      Poll.create({:user_id => 1, :body => "Is United States a positive factor for the world peace?", :yes => 'Yes', :no => 'No', :country_code => "us"}).update_attribute(:featured, true)
      
      Poll.create({:user_id => 2, :body => "Does China has democracy?", :yes => 'Yes', :no => 'No', :country_code => "cn"}).update_attribute(:featured, true)
      
      Poll.create({:user_id => 3, :body => "What's the role United States playing in the world?", :yes => "World Police", :no => "War Starter & Crusader", :country_code => "us"}).update_attribute(:featured, true)
      
      # ---------------------------(positive)? or ---(negative)?
      Poll.create({:user_id => 4, :body => "Is United States the world's peace keeper?", :yes => 'Yes', :no => "Trouble maker", :country_code => "us"})
      
      ## body applicable to all countries
      # User.find(1).askables.polls.create({:body => "Are you generally happy living in this country?", :country_code => "all", :coverage => 1})
      
      # domestic coverage
      Poll.create({:user_id => 2, :body => "Is Super Bowl a great event or what?", :yes => 'Yes', :no => 'No', :country_code => "us", :coverage => 1})
      
      # foreign coverage
      Poll.create({:user_id => 4, :body => "What is the image of China to you?", :yes => "Panda", :no => "Dragon", :country_code => "cn", :coverage => 2})
      
      Poll.create({:user_id => 1, :body => "Is it true that the next leader of China is decided before some kind of election?", :yes => 'Yes', :no => 'No', :country_code => "cn"}).update_attribute(:featured, true)
      Poll.create({:user_id => 1, :body => "Is China's 2-digit economy growth going to continue?", :yes => 'Yes', :no => 'No', :country_code => "cn"})
      Poll.create({:user_id => 1, :body => "Do you think western companies can compete successfully in China?", :yes => 'Yes', :no => 'No', :country_code => "cn"})
      Poll.create({:user_id => 1, :body => "Is there any great Chinese movie after Couching Tiger that is worth seeing?", :yes => 'Yes', :no => 'No', :country_code => "cn"})
      Poll.create({:user_id => 1, :body => "Do you think China's recent effort in the space a good idea?", :yes => 'Yes', :no => 'No', :country_code => "cn"})
      Poll.create({:user_id => 1, :body => "Will Xi Jinping return to a politically reformist path for the Chinese Communist Party?", :yes => 'Yes', :no => 'No', :country_code => "cn"})
      Poll.create({:user_id => 1, :body => "Why China backs North Korea?", :yes => "Humanitarian Reasons", :no => "To save it's own ass from being the evilest country in the world", :country_code => "cn"}).update_attribute(:featured, true)
      Poll.create({:user_id => 1, :body => "How is the human right status in China?", :yes => "Good", :no => "Bad", :coverage => 1, :country_code => "cn"})
      Poll.create({:user_id => 1, :body => "Is Shanghai safe place to live?", :yes => 'Yes', :no => 'No', :coverage => 1, :country_code => "cn"})
      Poll.create({:user_id => 1, :body => "Is China a potential travel destination for you?", :yes => 'Yes', :no => 'No', :coverage => 2, :country_code => "cn"})
      
      
      #Questions
      Question.create({:user_id => 2, :body => "US has been active involving in many military conflicts around the world for decades. Why didn't US step in and help people in Central Africa who are the most desperate in the world now?", :country_code => "us"})
      Question.create({:user_id => 1, :body => 'Why you believe Diaoyu Island belongs to China?', :country_code => 'cn'})
    end
  end
end
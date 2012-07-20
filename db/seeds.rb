# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

require 'db/seeds/countries.rb'

User.create(
  [
    {:name => 'yangb', :email  => 'b.yang@live.com', :country_code => "us", :password => '19781115', :password_confirmation  => '19781115'},
    {:name => 'goodguy', :email  => 'aaa@abc.com', :country_code => "us", :password => '111111', :password_confirmation  => '111111'},
    {:name => 'mideastguy', :email  => 'bbb@abc.com', :country_code => "ir", :password => '111111', :password_confirmation  => '111111'},
    {:name => 'commy', :email  => 'ccc@abc.com', :country_code => "kp", :password => '111111', :password_confirmation  => '111111'},
    {:name => '斯美丽', :email  => 'chino_carol@hotmail.com', :country_code => "cn", :password => '310carol', :password_confirmation  => '310carol'},
  ]
)


Poll.create(
  [
    {:question => "Is United States a positive factor for the world peace?", :user_id => 1, :country_code => "us", :category => 4, :weight => 5},
    {:question => "What's the role United States playing in the world?", :yes => "World Police", :no => "War Starter & Crusader", :user_id => 3, :country_code => "us", :category => 4, :weight => 4},
    
    # ---------------------------(positive)? or ---(negative)?
    {:question => "Is United States the world's peace keeper?", :no => "trouble maker", :user_id => 4, :country_code => "us", :category => 4, :weight => 4},
    
    # question applicable to all countries
    {:question => "Are you generally happy living in this country?", :user_id => 1, :country_code => "all", :coverage => 1, :category => 5, :weight => 7},
    
    # domestic coverage
    {:question => "Is Super Bowl a great event or what?", :country_code => "us", :user_id => 2, :coverage => 1, :category => 2, :weight => 2},
    
    # foreign coverage
    {:question => "What is the image of China to you?", :yes => "Panda", :no => "Dragon", :user_id => 4, :country_code => "cn", :coverage => 2, :category => 4, :weight => 3},
    
    
    {:question => "Is it true that the next leader of China is decided before some kind of election?", :user_id => 1, :country_code => "cn", :yes_positive => false, :category => 3, :weight => 6},
    {:question => "Is China's 2-digit economy growth going to continue?", :user_id => 1, :country_code => "cn", :category => 1, :weight => 2},
    {:question => "Do you think western companies can compete successfully in China?", :user_id => 1, :country_code => "cn", :category => 1, :weight => 1},
    {:question => "Is there any great Chinese movie after Couching Tiger that is worth seeing?", :user_id => 1, :country_code => "cn", :category => 2, :weight => 1},
    {:question => "Do you think China's recent effort in the space a good idea?", :user_id => 1, :country_code => "cn", :category => 4, :weight => 1},
    {:question => "Will Xi Jinping return to a politically reformist path for the Chinese Communist Party?", :user_id => 1, :country_code => "cn", :category => 3, :weight => 1},
    {:question => "Why China backs North Korea?", :yes => "Humanitarian Reasons", :no => "To save it's own ass from being the evilest country in the world", :user_id => 1, :country_code => "cn", :category => 4, :weight => 5},
    {:question => "How is the human right status in China?", :yes => "Good", :no => "Bad", :user_id => 1, :coverage => 1, :country_code => "cn", :category => 5, :weight => 1},
    {:question => "Is Shanghai safe place to live?", :user_id => 1, :coverage => 1, :country_code => "cn", :category => 5, :weight => 1},
    
    
    {:question => "Is China a potential travel destination for you?", :user_id => 1, :coverage => 2, :country_code => "cn", :category => 4, :weight => 1},

    
    # waiting approval
    {:question => "Does China has democracy?", :user_id => 2, :country_code => "cn", :category => 3}
  ]
)

Voting.create(
  [
    {:poll_id => 1, :user_id => 1, :country_code => "us", :vote => 1},
    {:poll_id => 2, :user_id => 1, :country_code => "us", :vote => 1},
    {:poll_id => 4, :user_id => 1, :country_code => "cn", :vote => -1},
    {:poll_id => 3, :user_id => 4, :country_code => "us", :vote => -1},
    {:poll_id => 7, :user_id => 4, :country_code => "cn", :vote => 1}
  ]
)

us = Country.find_by_code('us').id
cn = Country.find_by_code('cn').id
kp = Country.find_by_code('kp').id
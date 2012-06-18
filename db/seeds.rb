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
    {:login => 'yangb', :email  => 'b.yang@live.com', :password => '19781115', :password_confirmation  => '19781115'},
    {:login => 'goodguy', :email  => 'aaa@abc.com', :password => '111111', :password_confirmation  => '111111'},
    {:login => 'mideastguy', :email  => 'bbb@abc.com', :password => '111111', :password_confirmation  => '111111'},
    {:login => 'commy', :email  => 'ccc@abc.com', :password => '111111', :password_confirmation  => '111111'}
  ]
)


Poll.create(
  [
    {:question => "Is United States a positive factor for the world peace?", :user_id => 1, :country_code => "us", :category => 4, :weight => 5},
    {:question => "What's the role United States plays in the world?", :positive => "World Police", :negative => "War Starter & Crusader", :user_id => 3, :country_code => "us", :category => 4, :weight => 4},
    
    # ---------------------------(positive)? or ---(negative)?
    {:question => "Is United States the world's peace keeper?", :positive => nil, :negative => "trouble maker", :user_id => 4, :country_code => "us", :category => 4, :weight => 4},
    
    # question applicable to all countries
    {:question => "Are you generally happy living in this country?", :user_id => 1, :category => 5, :weight => 7},
    
    # domestic coverage
    {:question => "Is Super Bowl a great event or what?", :country_code => "us", :user_id => 2, :coverage => 1, :category => 2, :weight => 2},
    
    # foreign coverage
    {:question => "What is the image of China to you?", :positive => "Panda", :negative => "Dragon", :user_id => 4, :country_code => "cn", :category => 4, :weight => 3},
    
    # waiting approval
    {:question => "Does China has democracy?", :user_id => 2, :country_code => "cn", :category => 3, :weight => 0}
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

Rating.create(
  [
    {:country_id => us, :user_id => 1, :value => 91.0},
    {:country_id => us, :user_id => 2, :value => 88.0},
    {:country_id => us, :user_id => 3, :value => 70.0},
    {:country_id => cn, :user_id => 2, :value => 75.0},
    {:country_id => cn, :user_id => 4, :value => 98.0},
    {:country_id => kp, :user_id => 2, :value => 6.0},
    {:country_id => kp, :user_id => 4, :value => 91.0}
  ]
)
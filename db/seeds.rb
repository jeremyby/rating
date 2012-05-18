# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

require 'db/seeds/countries.rb'

Organization.create(
  [
    {:name => 'UN', :full_name  => 'United Nations'},
    {:name => 'IMF', :full_name => 'International Monetary Fund'}
  ]
)

User.create(
  [
    {:login => 'yangb', :email  => 'b.yang@live.com', :password => '19781115', :password_confirmation  => '19781115'},
    {:login => 'goodguy', :email  => 'aaa@abc.com', :password => '111111', :password_confirmation  => '111111'},
    {:login => 'mideastguy', :email  => 'bbb@abc.com', :password => '111111', :password_confirmation  => '111111'},
    {:login => 'commy', :email  => 'ccc@abc.com', :password => '111111', :password_confirmation  => '111111'}
  ]
)

us = Country.find_by_code('us').id
cn = Country.find_by_code('cn').id
kp = Country.find_by_code('kp').id

Rating.create(
  [
    {:ratable_id => us, :user_id => 1, :value => 91.0},
    {:ratable_id => us, :user_id => 2, :value => 88.0},
    {:ratable_id => us, :user_id => 3, :value => 70.0},
    {:ratable_id => cn, :user_id => 2, :value => 75.0},
    {:ratable_id => cn, :user_id => 4, :value => 98.0},
    {:ratable_id => kp, :user_id => 2, :value => 6.0},
    {:ratable_id => kp, :user_id => 4, :value => 91.0}
  ]
)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Country.create(
  [
    { :name => 'United States', :full_name => 'United States of America', :intro => 'Some cool introduction about the States.'},
    { :name => 'China', :full_name => "People's Republic of China", :intro => 'The biggest evil country of the world.'},
    { :name => 'United Kingdom', :full_name => 'United Kingkom of bla bla', :intro => 'The great little country.'}
  ]
)

Organization.create(
  [
    {:name => 'UN', :full_name  => 'United Nations'},
    {:name => 'IMF', :full_name => 'International Monetary Fund'}
  ]
)

User.create(
  [
    {:login => 'yangb', :email  => 'b.yang@live.com', :password => '19781115', :password_confirmation  => '19781115'}
  ]
)
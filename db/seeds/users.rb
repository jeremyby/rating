# encoding: utf-8

countries = %w(us cn uk kp sy)

users = [
  {:first_name => 'yangb', :email  => 'b.yang@live.com', :country_code => "us", :password => '19781115', :password_confirmation  => '19781115'},
  {:first_name => 'goodguy', :email  => 'aaa@abc.com', :country_code => "us", :password => '111111', :password_confirmation  => '111111'},
  {:first_name => 'mideastguy', :email  => 'bbb@abc.com', :country_code => "ir", :password => '111111', :password_confirmation  => '111111'},
  {:first_name => 'commy', :email  => 'ccc@abc.com', :country_code => "kp", :password => '111111', :password_confirmation  => '111111'},
  {:first_name => '美丽', :last_name => '斯', :email  => 'chino_carol@hotmail.com', :country_code => "cn", :password => '310carol', :password_confirmation  => '310carol'}
]

1000.times do |i|
  users << {:first_name => "user#{i+1}", :email  => "user#{i+1}@abc.com", :country_code => countries[rand(5)], :password => '111111', :password_confirmation  => '111111'}
end

users << {:first_name => 'Jeremy', :last_name => 'Yang', :email  => 'jeremyby@gmail.com', :country_code => "us", :password => '19781115', :password_confirmation  => '19781115'}

User.create(users)
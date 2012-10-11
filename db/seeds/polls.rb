# encoding: utf-8

User.find(1).polls.create({:question => "Is United States a positive factor for the world peace?", :country_code => "us", :category => "int", :weight => 5})


User.find(3).polls.create({:question => "What's the role United States playing in the world?", :yes => "World Police", :no => "War Starter & Crusader", :country_code => "us", :category => "int", :weight => 4})

# ---------------------------(positive)? or ---(negative)?
User.find(4).polls.create({:question => "Is United States the world's peace keeper?", :no => "trouble maker", :country_code => "us", :category => "int", :weight => 4})

# question applicable to all countries
User.find(1).polls.create({:question => "Are you generally happy living in this country?", :country_code => "all", :coverage => 1, :category => "ppl", :weight => 7})

# domestic coverage
User.find(2).polls.create({:question => "Is Super Bowl a great event or what?", :country_code => "us", :coverage => 1, :category => "cul", :weight => 2})

# foreign coverage
User.find(4).polls.create({:question => "What is the image of China to you?", :yes => "Panda", :no => "Dragon", :country_code => "cn", :coverage => 2, :category => "int", :weight => 3})


User.find(1).polls.create({:question => "Is it true that the next leader of China is decided before some kind of election?", :country_code => "cn", :positive_no => true, :category => "pol", :weight => 6}).update_attribute(:featured, true)
User.find(1).polls.create({:question => "Is China's 2-digit economy growth going to continue?", :country_code => "cn", :category => "eco", :weight => 2})
User.find(1).polls.create({:question => "Do you think western companies can compete successfully in China?", :country_code => "cn", :category => "eco", :weight => 1})
User.find(1).polls.create({:question => "Is there any great Chinese movie after Couching Tiger that is worth seeing?", :country_code => "cn", :category => "cul", :weight => 1})
User.find(1).polls.create({:question => "Do you think China's recent effort in the space a good idea?", :country_code => "cn", :category => "int", :weight => 1})
User.find(1).polls.create({:question => "Will Xi Jinping return to a politically reformist path for the Chinese Communist Party?", :country_code => "cn", :category => "pol", :weight => 1}).update_attribute(:featured, true)
User.find(1).polls.create({:question => "Why China backs North Korea?", :yes => "Humanitarian Reasons", :no => "To save it's own ass from being the evilest country in the world", :country_code => "cn", :category => "int", :weight => 5}).update_attribute(:featured, true)
User.find(1).polls.create({:question => "How is the human right status in China?", :yes => "Good", :no => "Bad", :coverage => 1, :country_code => "cn", :category => "ppl", :weight => 1})
User.find(1).polls.create({:question => "Is Shanghai safe place to live?", :coverage => 1, :country_code => "cn", :category => "ppl", :weight => 1}).update_attribute(:featured, true)


User.find(1).polls.create({:question => "Is China a potential travel destination for you?", :coverage => 2, :country_code => "cn", :category => "int", :weight => 1}).update_attribute(:featured, true)


# waiting approval
User.find(2).polls.create({:question => "Does China has democracy?", :country_code => "cn", :category => "pol"}).update_attribute(:featured, true)

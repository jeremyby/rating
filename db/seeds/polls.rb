# encoding: utf-8

User.find(1).polls.create({:question => "Is United States a positive factor for the world peace?", :country_code => "us"}).update_attribute(:featured, true)

User.find(2).polls.create({:question => "Does China has democracy?", :country_code => "cn"}).update_attribute(:featured, true)

User.find(3).polls.create({:question => "What's the role United States playing in the world?", :yes => "World Police", :no => "War Starter & Crusader", :country_code => "us"}).update_attribute(:featured, true)

# ---------------------------(positive)? or ---(negative)?
User.find(4).polls.create({:question => "Is United States the world's peace keeper?", :no => "Trouble maker", :country_code => "us"})

## question applicable to all countries
# User.find(1).polls.create({:question => "Are you generally happy living in this country?", :country_code => "all", :coverage => 1})

# domestic coverage
User.find(2).polls.create({:question => "Is Super Bowl a great event or what?", :country_code => "us", :coverage => 1})

# foreign coverage
User.find(4).polls.create({:question => "What is the image of China to you?", :yes => "Panda", :no => "Dragon", :country_code => "cn", :coverage => 2})

User.find(1).polls.create({:question => "Is it true that the next leader of China is decided before some kind of election?", :country_code => "cn"}).update_attribute(:featured, true)
User.find(1).polls.create({:question => "Is China's 2-digit economy growth going to continue?", :country_code => "cn"})
User.find(1).polls.create({:question => "Do you think western companies can compete successfully in China?", :country_code => "cn"})
User.find(1).polls.create({:question => "Is there any great Chinese movie after Couching Tiger that is worth seeing?", :country_code => "cn"})
User.find(1).polls.create({:question => "Do you think China's recent effort in the space a good idea?", :country_code => "cn"})
User.find(1).polls.create({:question => "Will Xi Jinping return to a politically reformist path for the Chinese Communist Party?", :country_code => "cn"})
User.find(1).polls.create({:question => "Why China backs North Korea?", :yes => "Humanitarian Reasons", :no => "To save it's own ass from being the evilest country in the world", :country_code => "cn"}).update_attribute(:featured, true)
User.find(1).polls.create({:question => "How is the human right status in China?", :yes => "Good", :no => "Bad", :coverage => 1, :country_code => "cn"})
User.find(1).polls.create({:question => "Is Shanghai safe place to live?", :coverage => 1, :country_code => "cn"})
User.find(1).polls.create({:question => "Is China a potential travel destination for you?", :coverage => 2, :country_code => "cn"})




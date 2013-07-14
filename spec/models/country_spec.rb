require "spec_helper"

describe "Country" do
  it 'should have 201 countries' do
    Country.all.size.should == 201
  end
  
  context 'of US' do
    before do
      @us = Country.find_by_code("us")
    end
    
    it 'should be there' do
      @us.should_not be_nil
    end
    
    it 'should have people living there' do
      @us.residents.should_not be_nil
      @us.residents.sample.should be_an_instance_of(User)
      @us.residents.sample.country_code.should == 'us'
    end
    
    it 'can be followed' do
      u = User.first
      u.follow(@us)
      
      @us.followings.where(:user_id => u.id).should be_present
      @us.followers.first.should == u
    end
  
    it 'should have polls' do
      @us.askables.polls.should_not be_nil
      poll = @us.askables.polls.build
      poll.should be_an_instance_of(Askable)
      poll.type.should == 'Poll'      
    end
  
    it 'should have ballots' do
      @us.answerables.ballots.should_not be_nil
      ballot = @us.answerables.ballots.build
      ballot.should be_an_instance_of(Answerable)
      ballot.type.should == 'Ballot'
    end
    
    it 'should have a slug' do
      @us.slug.should be_present
    end
    
    it 'sometime has a pretty name' do
      @us.to_s.should == @us.name
      kp = Country.find_by_code('kp')
      kp.to_s.should == kp.pretty_name
    end
  end
  
  context "GeoIP" do
    it "should recognize an IP addresses and country info" do
      info = @geoip.country "184.106.169.25"
      info.country_code.should be > 0
      info.country_code2.should == "US"
      
      info = @geoip.country "58.35.93.205"
      info.country_code.should be > 0
      info.country_code2.should == "CN"
      
      info = @geoip.country "www.ed.ac.uk"
      info.country_code.should be > 0
      info.country_code2.should == "GB"
      
      info = @geoip.country "www.paris-universitas.fr"
      info.country_code.should be > 0
      info.country_code2.should == "FR"
      
      info = @geoip.country "www.kcna.kp"
      info.country_code.should be > 0
      info.country_code2.should == "KP"
    end
    
    it "should recognize invalid IP addresses" do
      info = @geoip.country "127.0.0.1"
      info.country_code.should == 0
      
      info = @geoip.country "192.168.1.1"
      info.country_code.should == 0
      
      info = @geoip.country "10.0.0.1"
      info.country_code.should == 0
    end
  end
end
require "spec_helper"

describe "Country" do
  it 'should have 206 countries' do
    Country.all.size.should == 206
  end
  
  context 'of US' do
    before do
      @us = Country.find_by_code("us")
      @user = create(:yangb)
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
      @user.follow(@us)
      
      @us.followings.where(:user_id => @user.id).should be_present
      @us.followers.first.should == @user
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
    
    it 'should have questions' do
      @us.askables.questions.should_not be_nil
      
      q = @us.askables.questions.build
      q.should be_an_instance_of(Askable)
      q.type.should == 'Question'      
    end
  
    it 'should have answers' do
      @us.answerables.answers.should_not be_nil
      
      a = @us.answerables.answers.build
      a.should be_an_instance_of(Answerable)
      a.type.should == 'Answer'
    end
    
    it 'should have events' do
     
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
      info = Geoip.country "184.106.169.25"
      info.country_code.should be > 0
      info.country_code2.should == "US"
      
      info = Geoip.country "58.35.93.205"
      info.country_code.should be > 0
      info.country_code2.should == "CN"
      
      info = Geoip.country "www.ed.ac.uk"
      info.country_code.should be > 0
      info.country_code2.should == "GB"
      
      info = Geoip.country "www.paris-universitas.fr"
      info.country_code.should be > 0
      info.country_code2.should == "FR"
      
      info = Geoip.country "www.kcna.kp"
      info.country_code.should be > 0
      info.country_code2.should == "KP"
    end
    
    it "should recognize invalid IP addresses" do
      info = Geoip.country "127.0.0.1"
      info.country_code.should == 0
      
      info = Geoip.country "192.168.1.1"
      info.country_code.should == 0
      
      info = Geoip.country "10.0.0.1"
      info.country_code.should == 0
    end
  end
end
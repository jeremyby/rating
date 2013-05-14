require "spec_helper"

describe "Askable" do
  it 'should have scope: featured' do
    featured = Poll.featured
    featured.should_not be_nil
    featured.first.featured.should be_true
  end
  
  context 'with id = 7,' do
    before do
      @poll = Askable.find(7)
    end
    
    it 'should have the type of Poll' do
      @poll.type.should == 'Poll'
    end
    
    it 'should have an accessor :truncate_slug' do
      @poll.should respond_to(:truncate_slug)
      @poll.truncate_slug.should == "Is it true that the next leader of China is"
    end
  
    it 'should have a slug for friendly_id' do
      @poll.should respond_to(:slug)
      @poll.slug.should == "is-it-true-that-the-next-leader-of-china-is"
    end
    
    it 'should have ballots, coz it is a poll' do
      @poll.ballots.should_not be_nil
      @poll.ballots.build().should be_an_instance_of(Ballot)
    end
    
    it 'can be followed' do
      u = User.first
      u.follow(@poll)
      
      @poll.followings.where(:user_id => u.id).should be_present
      @poll.followers.first.should == u
    end
    
    it 'should belong to a country' do
      @poll.country.code.should == 'cn'
      @poll.country.askables_count.should > 0      
    end
    
    it 'should have an owner' do
      @poll.owner.should be_an_instance_of(User)
      @poll.owner.id.should == 1
    end
    
    it 'should to_s body' do
      @poll.to_s.should == @poll.body
    end
    
    it 'has a method to load more random polls of the same country' do
      @poll.more_askables.should have_exactly(4).items
      @poll.more_askables(6).should have_exactly(6).items
      
      @poll.more_askables.map(&:id).should_not == @poll.more_askables.map(&:id)
    end
    
    it 'should tell it is simple or not' do
      @poll.simple?.should be_true
      Askable.find(3).simple?.should be_false
    end

    it 'should tell it is "or negative"' do
      @poll.or_negative?.should be_false
      Askable.find(4).or_negative?.should be_true
    end
  end
  
  it 'should validate on the presnece of some attributes' do
    poll = Poll.new(:body => 'test')
    
    poll.save.should be_false
    poll.errors.should be_present
    poll.errors[:body].should be_present
    poll.errors[:user_id].should be_present
    poll.errors[:country_code].should be_present
    
    poll.errors[:coverage].should be_blank
    poll.errors[:yes].should be_blank
    poll.errors[:no].should be_blank
  end
  
  it 'should raise error if no body' do
    poll = Poll.new
    
    expect { poll.save! }.to raise_error
  end
  
  it 'cannot mass-assign featured attribute' do
    expect { Poll.new(:user_id => 1, :body => 'a valid test', :country_code => 'us', :featured => true) }.to raise_error
  end
  
  context 'when being created,' do
    before do
      @poll = Poll.new(:user_id => 1, :body => 'a valid test', :country_code => 'us')
    end
    
    it 'can be created' do
      @poll.save.should be_true
    end
    
    it 'can need to have a question' do
      @poll.body = ''
      @poll.save.should be_false
      @poll.errors[:body].should be_present
    end
    
    it 'should have a valid question' do
      @poll.body = 'too short'
      @poll.save.should be_false
      @poll.errors[:body].should be_present
      
      # @poll.question = 'tooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo long'
      #       @poll.save.should be_false
      #       @poll.errors[:question].should be_present
    end
    
    it 'can be created, with custom yes/no' do
      @poll.yes = 'something positive'
      @poll.no = 'someting negative'
      @poll.save.should be_true
    end
    
    it 'should not have duplicated questions for a same country' do
      @poll.save
      
      new_poll = Poll.new(:body => 'a valid test', :user_id => 2, :country_code => 'us')
      new_poll.save.should be_false
      new_poll.errors[:body].should be_present
      
      new_poll.country_code = 'cn'
      new_poll.save.should be_true
    end
  end
end
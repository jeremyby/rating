require "spec_helper"

describe "Poll" do
  it 'should have scope: featured' do
    featured = Poll.featured
    featured.should_not be_nil
    featured.first.featured.should be_true
  end
  
  context 'with id = 7,' do
    before do
      @poll = Poll.find(7)
    end
    
    it 'should have an accessor :question_reformat' do
      @poll.should respond_to(:question_reformat)
      @poll.question_reformat.should == "is it true that the next leader of china is"
    end
  
    it 'should have a slug for friendly_id' do
      @poll.should respond_to(:slug)
      @poll.slug.should == "is-it-true-that-the-next-leader-of-china-is"
    end
    
    it 'should have ballots' do
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
      @poll.country.polls_count.should > 0      
    end
    
    it 'should have an owner' do
      @poll.owner.should be_an_instance_of(User)
      @poll.owner.id.should == 1
    end
    
    it 'should to_s question' do
      @poll.to_s.should == @poll.question
    end
    
    it 'has a method to load more random polls of the same country' do
      @poll.more_polls.should have_exactly(4).items
      @poll.more_polls(6).should have_exactly(6).items
      
      @poll.more_polls.first.should_not == @poll.more_polls.first
    end
  end
  
  it 'should validate on the presnece of some attributes' do
    poll = Poll.new(:question => 'test')
    
    poll.save.should be_false
    poll.errors.should be_present
    poll.errors[:user_id].should be_present
    poll.errors[:country_code].should be_present
    
    poll.errors[:coverage].should be_blank
    poll.errors[:yes].should be_blank
    poll.errors[:no].should be_blank
  end
  
  it 'should raise error if no question, because of friendly_id' do
    poll = Poll.new
    
    expect { poll.save }.to raise_error
  end
  
  it 'cannot mass-assign featured attribute' do
    expect { Poll.new(:user_id => 1, :question => 'test', :country_code => 'us', :featured => true) }.to raise_error
  end
  
  context 'when being created,' do
    before do
      @poll = Poll.new(:user_id => 1, :question => 'a valid test', :country_code => 'us')
    end
    
    it 'can be created' do
      @poll.save.should be_true
    end
    
    it 'can need to have a question' do
      @poll.question = ''
      @poll.save.should be_false
      @poll.errors[:question].should be_present
    end
    
    it 'should have a valid question' do
      @poll.question = 'too short'
      @poll.save.should be_false
      @poll.errors[:question].should be_present
      
      @poll.question = 'tooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo long'
      @poll.save.should be_false
      @poll.errors[:question].should be_present
    end
    
    it 'can be created, with custom yes/no' do
      @poll.yes = 'something positive'
      @poll.no = 'someting negative'
      @poll.save.should be_true
    end
    
    it 'should not have duplicated questions for a same country' do
      @poll.save
      
      new_poll = Poll.new(:question => 'a valid test', :user_id => 2, :country_code => 'us')
      new_poll.save.should be_false
      new_poll.errors[:question].should be_present
      
      new_poll.country_code = 'cn'
      new_poll.save.should be_true
    end
  end
  
  it 'should tell it is simple or not' do
    Poll.first.simple?.should be_true
    Poll.find(3).simple?.should be_false
  end
  
  it 'should tell it is "or negative"' do
    Poll.first.or_negative?.should be_false
    Poll.find(4).or_negative?.should be_true
  end
end
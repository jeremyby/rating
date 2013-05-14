require "spec_helper"

describe "User" do
  it 'should have an accessor: password_confirmation' do
    u = User.first
    u.should respond_to(:password_confirmation)
  end
  
  context 'when being created,' do
    before do
      @new = User.new(:first_name => 'yangb', :email  => 'b.yang@abc.com', :country_code => "us", :password => '19781115', :password_confirmation  => '19781115')
    end
    
    it 'can be created' do
      @new.save.should be_true
    end
    
    it 'cannot mass-assign admin' do
      expect { User.new(:first_name => 'yangb', :email  => 'b.yang@abc.com', :country_code => "us", :password => '19781115', :password_confirmation  => '19781115', :admin => true) }.to raise_error
    end
    
    it 'requires first name' do
      @new.first_name = nil
      @new.save.should be_false
      @new.errors[:first_name].should be_present
    end
    
    it 'requires email' do
      @new.email = nil
      @new.save.should be_false
      @new.errors[:email].should be_present
    end
    
    it 'should not have duplicated emails' do
      @new.email = 'b.yang@live.com'
      @new.save.should be_false
      @new.errors[:email].should be_present
    end
  end
  
  context 'with id = 1' do
    before do
      @user = User.find(1)
    end
    
    it 'should belong to a country' do
      @user.country.should be_an_instance_of(Country)
      @user.country.code.should == 'us'
    end    
  end
end
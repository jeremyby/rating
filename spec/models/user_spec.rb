require "spec_helper"

describe "User" do
  # fixtures :users
  
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
  end
  
  context 'of yangb' do
    before do
      @user = create(:yangb)
    end
    
    it 'should not have duplicated emails' do
      @new = User.new(:first_name => 'yangb', :email  => 'b.yang@live.com', :country_code => "us", :password => '19781115', :password_confirmation  => '19781115')
      @new.save.should be_false
      @new.errors[:email].should be_present
    end
    
    it 'should have an accessor: password_confirmation' do
      @user.should respond_to(:password_confirmation)
    end
    
    it 'should belong to a country' do
      @user.country.should be_an_instance_of(Country)
      @user.country.code.should == 'us'
    end    
  end
end
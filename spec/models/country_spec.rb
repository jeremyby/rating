require 'spec_helper'

describe Country do
  it 'should has America' do
    us = Country.find_by_code("us")
    us.should_not be_nil
    us.code.should == "us"
  end
end

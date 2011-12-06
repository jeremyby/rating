require 'spec_helper'

describe Country do
  it 'should has America as the first record' do
    us = Country.first
    us.should_not be_nil
    us.code.should == 'us'
  end
end

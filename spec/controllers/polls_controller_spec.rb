require 'spec_helper'

describe PollsController do
  describe "GET 'show' no params" do
    it "should go page something wrong" do
      get 'show'
      response.should redirect_to("/404.html")
    end
  end
  
  
  describe "GET 'show' wrong poll" do
    it "should go page not found" do
      get 'show', :id => "non-exist poll", :country_id => "us"
      response.should redirect_to("/404.html")
    end
  end
  
  describe "GET 'show' wrong country" do
    it "should go page not found" do
      get 'show', :id => "are-you-generally-happy-living-in-this-country", :country_id => "aa"
      response.should redirect_to("/404.html")
    end
  end
  
  describe "GET 'show'" do
    it "should work" do
      get 'show', :id => "are-you-generally-happy-living-in-this-country", :country_id => "united-states"
      response.should be_success
    end
  end
end

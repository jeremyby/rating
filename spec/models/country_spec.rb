require "spec_helper"

describe "Country" do
  it "should have United States" do
    us = Country.find_by_code("us")
    us.should_not be_nil
  end
  
  context "GeoIP" do
    it "should recognize an IP address from United States" do
      info = $geoip.country "184.106.169.25"
      info.country_code.should be > 0
      info.country_code2.should == "US"
    end
    
    it "should recognize an IP address from China" do
      info = $geoip.country "58.35.93.205"
      info.country_code.should be > 0
      info.country_code2.should == "CN"
    end
    
    it "should recognize an IP address from UK" do
      info = $geoip.country "www.ed.ac.uk"
      info.country_code.should be > 0
      info.country_code2.should == "GB"
    end
    
    it "should recognize an IP address from France" do
      info = $geoip.country "www.paris-universitas.fr"
      info.country_code.should be > 0
      info.country_code2.should == "FR"
    end
    
    it "should recognize an IP address from South Korea" do
      info = $geoip.country "www.kcna.kp"
      info.country_code.should be > 0
      info.country_code2.should == "KP"
    end
    
    it "should recognize invalid IP addresses" do
      info = $geoip.country "127.0.0.1"
      info.country_code.should == 0
      
      info = $geoip.country "192.168.1.1"
      info.country_code.should == 0
      
      info = $geoip.country "10.0.0.1"
      info.country_code.should == 0
    end
  end
end
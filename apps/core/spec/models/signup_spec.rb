require File.expand_path("../../spec_helper", __FILE__)

describe Airstrip::Signup do
  describe "#set_client_info" do
    it "sets given client's ip and referer information" do
      subject.set_client_info("127.0.0.1", "google.com")
      subject.ip_address.should == "127.0.0.1"
      subject.referer.should == "google.com"
    end
  end

  describe ".referers" do
    before do
      Airstrip::Signup.destroy_all
      2.times { Airstrip::Signup.make!(:referer => 'http://google.com') }
      Airstrip::Signup.make!(:referer => nil)
    end

    it "returns list of referring websites together with number of users brought" do
      referers = Airstrip::Signup.referers
      referers.to_a.should have(1).item
      referers.first.url.should == "http://google.com"
      referers.first.users_count.should == 2
    end
  end

  context "locations" do
    before do
      Airstrip::Signup.destroy_all
      2.times { Airstrip::Signup.make!(:city => "Montevideo", :country => "Uruguay") }
      Airstrip::Signup.make!(:city => nil, :country => nil)
    end
    
    describe ".cities" do
      it "returns list of cities with number of users from there" do
        cities = Airstrip::Signup.cities
        cities.to_a.should have(1).item
        cities.first.city.should == "Montevideo"
        cities.first.country.should == "Uruguay"
        cities.first.users_count.should == 2
      end
    end

    describe ".countries" do
      it "returns list of countries with number of users from there" do
        countries = Airstrip::Signup.countries
        countries.to_a.should have(1).item
        countries.first.country.should == "Uruguay"
        countries.first.users_count.should == 2
      end
    end
  end
end

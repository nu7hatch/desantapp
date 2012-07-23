require File.expand_path("../../spec_helper", __FILE__)

describe Desant::Signup do
  describe "#set_client_info" do
    it "sets given client's ip and referer information" do
      subject.set_client_info("127.0.0.1", "google.com")
      subject.ip_address.should == "127.0.0.1"
      subject.referer.should == "google.com"
    end
  end

  describe ".referers" do
    before do
      Desant::Signup.destroy_all
      2.times { Desant::Signup.make!(:referer => 'http://google.com') }
      Desant::Signup.make!(:referer => nil)
    end

    it "returns list of referring websites together with number of users brought" do
      referers = Desant::Signup.referers
      referers.to_a.should have(1).item
      referers.first.url.should == "http://google.com"
      referers.first.users_count.should == 2
    end
  end

  context "locations" do
    before do
      Desant::Signup.destroy_all
      2.times { Desant::Signup.make!(:city => "Montevideo", :country => "Uruguay") }
      Desant::Signup.make!(:city => nil, :country => nil)
    end
    
    describe ".cities" do
      it "returns list of cities with number of users from there" do
        cities = Desant::Signup.cities
        cities.to_a.should have(1).item
        cities.first.city.should == "Montevideo"
        cities.first.country.should == "Uruguay"
        cities.first.users_count.should == 2
      end
    end

    describe ".countries" do
      it "returns list of countries with number of users from there" do
        countries = Desant::Signup.countries
        countries.to_a.should have(1).item
        countries.first.country.should == "Uruguay"
        countries.first.users_count.should == 2
      end
    end
  end
end

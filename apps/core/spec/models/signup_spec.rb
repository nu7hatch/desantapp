require File.expand_path("../../spec_helper", __FILE__)

describe Airstrip::Signup do
  describe "#set_client_info" do
    it "sets given client's ip and referer information" do
      subject.set_client_info("127.0.0.1", "google.com")
      subject.ip_address.should == "127.0.0.1"
      subject.referrer.should == "google.com"
    end
  end
end

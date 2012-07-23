require File.expand_path("../../spec_helper", __FILE__)

describe Desant::SignupService do
  subject do
    Desant::SignupService
  end

  context "when given email address is valid and not duplicated" do
    let :app do
      stub(
        :params  => { :signup => { 'email' => "chris@nu7hat.ch" } },
        :request => stub(:ip => "127.0.0.1"),
        :session => { :referer => "http://www.dummy.com/blog/post" }
      )
    end

    it "creates new signup entry" do
      res = subject.new(app).call
      res.should == { "email" => "chris@nu7hat.ch" }
      Desant::Signup.find_by_email("chris@nu7hat.ch").should be
    end
  end

  context "when errors encountered" do
    let :app do
      stub(
        :params  => {},
        :request => stub(:ip => "127.0.0.1"),
        :session => {}
      )
    end

    it "returns error messages" do
      on_error = false
      service = subject.new(app)
      service.on_error { on_error = true }
      res = service.call
      on_error.should be
      res[:error].should == "Email has invalid format"
    end
  end
end

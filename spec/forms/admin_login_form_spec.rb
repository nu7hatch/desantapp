require File.expand_path("../../spec_helper", __FILE__)

describe Airstrip::AdminLoginForm do
  subject do
    Airstrip::AdminLoginForm
  end

  before do
    ENV['ADMIN_LOGIN'] = "jack"
    ENV['ADMIN_PASSWORD_HASH'] = BCrypt::Password.create("secret")
  end

  context "when given credentials are valid" do
    it "logs in correctly and executes passed block" do
      on_success = nil
      res = subject.new("jack", "secret").call { |login| on_success = login }
      res.should == { :login => "jack" }
      on_success.should == "jack"
    end
  end

  context "when errors encountered" do
    it "returns error messages and doesn't execute passed block" do
      on_success, on_error = false, false
      form = subject.new("joe", "hello")
      form.on_error { on_error = true }
      res = form.call { |login| on_success = login }
      res[:error].should == "Credentials are invalid"
      on_success.should_not be
    end
  end
end

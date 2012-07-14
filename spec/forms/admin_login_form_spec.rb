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
      block_call = nil
      res = subject.new("jack", "secret").call { |login| block_call = login }
      res.should == { :login => "jack" }
      block_call.should == "jack"
    end
  end

  context "when errors encountered" do
    it "returns error messages and doesn't execute passed block" do
      block_call = nil
      res = subject.new("joe", "hello").call { |login| block_call = login }
      res.full_messages.to_sentence.should == "Credentials are invalid"
      block_call.should_not be
    end
  end
end

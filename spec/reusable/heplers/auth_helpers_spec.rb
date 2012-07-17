require File.expand_path("../../../spec_helper", __FILE__)

class DummyAppWithAuthHelpers
  include Reusable::AuthHelpers

  def session
    @session ||= {}
  end
end

describe Reusable::AuthHelpers do
  let :app do
    DummyAppWithAuthHelpers.new
  end

  describe "#logged_in?" do
    it "returns true when authenticated" do
      app.session[:logged_in] = "joe"
      app.should be_logged_in
    end

    it "returns false when not authenticated" do 
      app.session[:logged_in] = nil
      app.should_not be_logged_in 
    end
  end

  describe "#current_user" do
    it "return nothing when not authenticated" do
      app.session[:logged_in] = nil
      app.current_user.should_not be
    end

    it "returns user name when authenticated" do
      app.session[:logged_in] = "joe"
      app.current_user.should == "joe"
    end
  end

  describe "#authenticate!" do
    it "authenticates specified user" do
      app.authenticate!("joe", "token")
      app.should be_logged_in
      app.current_user.should == "joe"
      app.current_session_token.should == "token"
      app.auth_data.should == { :login => "joe", :access_token => "token" }
    end
  end

  describe "#log_out!" do
    it "closes current session" do
      app.log_out!
      app.should_not be_logged_in
    end
  end
end

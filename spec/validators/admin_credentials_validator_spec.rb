require File.expand_path("../../spec_helper", __FILE__)

class DummyModelWithAdminCredentials < Struct.new(:login, :password)
  include ActiveModel::Validations
  validates :password, :admin_credentials => true
end

describe AdminCredentialsValidator do
  before do
    ENV['ADMIN_LOGIN'] = "jack"
    ENV['ADMIN_PASSWORD_HASH'] = BCrypt::Password.create("secret")
  end
  
  it "adds validation error when credentials are invalid" do
    dummy = DummyModelWithAdminCredentials.new("joe", "something")
    dummy.should_not be_valid
    dummy.errors[:credentials].should include("are invalid")
  end
  
  it "does nothing when credentials are valid" do
    dummy = DummyModelWithAdminCredentials.new("jack", "secret")
    dummy.should be_valid
  end
end

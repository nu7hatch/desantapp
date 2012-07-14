require File.expand_path("../../../spec_helper", __FILE__)

class DummyModelWithEmail
  include ActiveModel::Validations

  attr_accessor :email
  validates :email, :presence => true, :email => true

  def initialize(email)
    @email = email
  end
end

describe EmailValidator do
  it "adds validation error when email is invalid" do
    dummy = DummyModelWithEmail.new("invalid@email")
    dummy.should_not be_valid
    dummy.errors[:email].should include("has invalid format")
  end
  
  it "does nothing when email is valid" do
    dummy = DummyModelWithEmail.new("chris@nu7hat.ch")
    dummy.should be_valid
  end
end

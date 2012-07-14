require File.expand_path("../../spec_helper", __FILE__)

describe Airstrip::LatestSignupsPresenter do
  subject do
    Airstrip::LatestSignupsPresenter
  end

  before do
    Airstrip::Signup.destroy_all
    2.times { Airstrip::Signup.make! }
  end

  it "loads paginated list of latest signups" do
    res = subject.new(1).call
    res.should have(2).items
    res.first.keys.should =~ %w(id email ip_address referrer created_at)
  end
end

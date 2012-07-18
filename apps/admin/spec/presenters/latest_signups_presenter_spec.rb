require File.expand_path("../../spec_helper", __FILE__)

describe Airstrip::Admin::LatestSignupsPresenter do
  subject do
    Airstrip::Admin::LatestSignupsPresenter
  end

  before do
    Airstrip::Signup.destroy_all
    2.times { Airstrip::Signup.make! }
  end

  it "loads paginated list of latest signups" do
    res = subject.new(1).call
    res[:signups].should have(2).items
    res[:signups].first.keys.should =~ %w(id email ip_address referer created_at)
    res[:total_count].should == 2
  end
end

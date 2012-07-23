require File.expand_path("../../spec_helper", __FILE__)

describe Desant::Admin::LatestSignupsPresenter do
  subject do
    Desant::Admin::LatestSignupsPresenter
  end

  before do
    Desant::Signup.destroy_all
    2.times { Desant::Signup.make! }
  end

  it "loads paginated list of latest signups" do
    res = subject.new(1).call
    res[:signups].should have(2).items
    res[:signups].first.keys.should =~ %w(id email ip_address referer created_at city country)
    res[:total_count].should == 2
  end
end

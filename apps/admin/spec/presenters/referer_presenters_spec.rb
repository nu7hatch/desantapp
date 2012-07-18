require File.expand_path("../../spec_helper", __FILE__)

describe Airstrip::Admin::ReferersPresenter do
  subject do
    Airstrip::Admin::ReferersPresenter
  end

  before do
    Airstrip::Signup.destroy_all
    2.times { Airstrip::Signup.make!(:referer => 'http://google.com') }
    Airstrip::Signup.make!(:referer => nil)
  end

  it "loads paginated list of refering websites with number of brought users" do
    res = subject.new(1).call
    res[:referers].should have(1).items
    res[:referers].first.keys.should =~ %w(id url users_count)
    res[:total_count].should == 1
  end
end

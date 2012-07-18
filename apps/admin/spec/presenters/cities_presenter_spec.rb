require File.expand_path("../../spec_helper", __FILE__)

describe Airstrip::Admin::CitiesPresenter do
  subject do
    Airstrip::Admin::CitiesPresenter
  end

  before do
    Airstrip::Signup.destroy_all
    2.times { Airstrip::Signup.make!(:city => "Montevideo", :country => "Uruguay") }
    Airstrip::Signup.make!(:city => nil, :country => nil)
  end

  it "loads paginated list of refering websites with number of brought users" do
    res = subject.new(1).call
    res[:cities].should have(1).items
    res[:cities].first.keys.should =~ %w(id city country users_count)
    res[:total_count].should == 1
  end
end

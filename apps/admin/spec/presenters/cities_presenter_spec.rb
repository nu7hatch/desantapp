require File.expand_path("../../spec_helper", __FILE__)

describe Desant::Admin::CitiesPresenter do
  subject do
    Desant::Admin::CitiesPresenter
  end

  before do
    Desant::Signup.destroy_all
    2.times { Desant::Signup.make!(:city => "Montevideo", :country => "Uruguay") }
    Desant::Signup.make!(:city => nil, :country => nil)
  end

  it "loads paginated list of refering websites with number of brought users" do
    res = subject.new(1).call
    res[:cities].should have(1).items
    res[:cities].first.keys.should =~ %w(id city country users_count)
    res[:total_count].should == 1
  end
end

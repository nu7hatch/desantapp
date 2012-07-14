require File.expand_path("../../spec_helper", __FILE__)

describe Hash do
  describe "#pick" do
    it "returns new hash composed from the specified keys" do
      hash = { :foo => 1, :bar => 2, :baz => 3 }
      new_hash = hash.pick(:foo, :baz)
      new_hash.keys.should =~ [:foo, :baz]
      new_hash[:foo].should == 1
      new_hash[:baz].should == 3
    end
  end
end

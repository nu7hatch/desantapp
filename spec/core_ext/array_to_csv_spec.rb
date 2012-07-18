require File.expand_path("../../spec_helper", __FILE__)

describe Array do
  context "of hashes" do
    describe "#to_csv" do
      subject do
        [ { :foo => 1, :bar => 2 },
          { :foo => 3, :bar => 4 } ]
      end

      it "returns data converted to CSV format" do
        subject.to_csv.should == "bar,foo\n2,1\n4,3\n"
      end
      
      context "when option :headers set to false" do
        it "returns data converted to CSV without headers" do
          subject.to_csv(:headers => false).should == "2,1\n4,3\n"
        end
      end
    end
  end
end

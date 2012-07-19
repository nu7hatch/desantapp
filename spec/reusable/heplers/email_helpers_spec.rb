require File.expand_path("../../../spec_helper", __FILE__)
require 'reusable/helpers/email_helpers'

describe Reusable::EmailHelpers do
  describe "#anonimize_email" do
    it "returns 3 first characters of username with dots if longer than 3 chars" do
      subject.anonimize_email('marty@macfly.com').should == 'mar...@macfly.com'
    end

    it "returns first characted of username with dots if shorther than 3 chars" do
      subject.anonimize_email('ba@barracus.com').should == 'b...@barracus.com'
    end
  end
end
